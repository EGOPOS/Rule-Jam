class_name Cursor extends CharacterBody2D

@export var speed: float = 8.0
@export var grabbing_speed: float = 16.0
#@export var acceleration: float = 2.0
#@export var friction: float = 1.0

@onready var grab_area = $GrabArea2D
var object_to_grab: Grabbing
var object_to_interact: Interacting
var can_grab = true
var can_dash: bool = true
var minimum_dash_velocity: int = 1200

@onready var animation_player = $AnimationPlayer
@onready var hurt_area_component = $HurtAreaComponent2D

@onready var grab_player = $GrabAudioStreamPlayer
@onready var ungrab_player = $UngrabAudioStreamPlayer

func _ready():
	grab_area.body_entered.connect(on_grab_enterd)
	grab_area.body_exited.connect(on_grab_exited)
	grab_area.area_entered.connect(on_area_entered)
	grab_area.area_exited.connect(on_area_exited)

func on_area_entered(area):
	if area.is_in_group("ungrab"):
		can_grab = false
	if area is Interacting:
		object_to_interact = area
	
func on_area_exited(area):
	if area.is_in_group("ungrab"):
		can_grab = true
	if area is Interacting:
		object_to_interact = null

func on_grab_enterd(body):
	if body is Grabbing:
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
	
	hurt_area_component.monitoring = velocity.length() > minimum_dash_velocity
	#can_dash = velocity.length() > minimum_dash_velocity
	#print(can_dash)
	#if can_dash and velocity.length() > minimum_dash_velocity:
		#velocity *= 3.0
		#can_dash = false
	
	move_and_slide()
	
	if (not object_to_grab or not can_grab) and not object_to_interact:
		animation_player.play("idle")
		if grab_area.get_overlapping_bodies().size():
			object_to_grab = grab_area.get_overlapping_bodies()[0]
		return
	
	if Input.is_action_just_pressed("grab"):
		grab_player.play()
		grab()
		interact()
	
	if Input.is_action_pressed("grab"):
		#object_to_grab.global_position += direction * delta * grabbing_speed * target_delta.length()
		if object_to_grab:
			object_to_grab.linear_velocity = direction * delta * grabbing_speed * target_delta.length()
			animation_player.play("catch")
		grab()
	else:
		animation_player.play("ready_to_catch")
	
	if Input.is_action_just_released("grab"):
		ungrab_player.play()
		ungrab()


func grab():
	if object_to_grab:
		object_to_grab.grab(global_position)
		hurt_area_component.get_child(0).disabled = true

func ungrab():
	if object_to_grab:
		object_to_grab.ungrab()
		hurt_area_component.get_child(0).disabled = false

func interact():
	if object_to_interact:
		object_to_interact.interact(global_position)
