class_name Cursor extends CharacterBody2D

@export var speed: float = 8.0
@export var grabbing_speed: float = 16.0
#@export var acceleration: float = 2.0
#@export var friction: float = 1.0

@onready var grab_area = $GrabArea2D
var object_to_grab: RigidBody2D

func _ready():
	grab_area.body_entered.connect(on_grab_enterd)
	grab_area.body_exited.connect(on_grab_exited)

func on_grab_enterd(body):
	object_to_grab = body

func on_grab_exited(body):
	await get_tree().physics_frame
	object_to_grab.freeze = false
	object_to_grab.sleeping = false
	object_to_grab = null


func _process(delta):
	#global_position = global_position.lerp(get_global_mouse_position(), delta * speed)
	var target_delta = get_global_mouse_position() - global_position
	var direction = target_delta.normalized()
	velocity = direction * delta * speed * target_delta.length()
	move_and_slide()
	
	if not object_to_grab: return
	
	if Input.is_action_just_pressed("grab"):
		object_to_grab.freeze = true
	
	if Input.is_action_pressed("grab"):
		object_to_grab.global_position = object_to_grab.global_position.lerp(global_position, delta * grabbing_speed)
	
	if Input.is_action_just_released("grab"):
		object_to_grab.freeze = false
