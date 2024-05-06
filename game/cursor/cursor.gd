class_name Cursor extends CharacterBody2D

@export var speed: float = 8.0
@export var grabbing_speed: float = 16.0
#@export var acceleration: float = 2.0
#@export var friction: float = 1.0

@onready var grab_area = $GrabArea2D
var object_to_grab: RigidBody2D

@onready var animation_player = $AnimationPlayer

func _ready():
	grab_area.body_entered.connect(on_grab_enterd)
	grab_area.body_exited.connect(on_grab_exited)

func on_grab_enterd(body):
	if body is RigidBody2D:
		object_to_grab = body

func on_grab_exited(body):
	await get_tree().physics_frame
	if is_instance_valid(body):
		body.ungrab()
	object_to_grab = null

func _physics_process(delta):
	var target_delta = get_global_mouse_position() - global_position
	var direction = target_delta.normalized()
	velocity = direction * delta * speed * target_delta.length()
	move_and_slide()
	
	if not object_to_grab:
		animation_player.play("idle")
		if grab_area.get_overlapping_bodies().size():
			object_to_grab = grab_area.get_overlapping_bodies()[0]
		return
	
	if Input.is_action_just_pressed("grab"):
		grab()
	
	if Input.is_action_pressed("grab"):
		#object_to_grab.global_position += direction * delta * grabbing_speed * target_delta.length()
		object_to_grab.linear_velocity = direction * delta * grabbing_speed * target_delta.length()
		animation_player.play("catch")
		grab()
	else:
		animation_player.play("ready_to_catch")
	
	if Input.is_action_just_released("grab"):
		ungrab()

func grab():
	object_to_grab.grab(global_position)

func ungrab():
	object_to_grab.ungrab()
