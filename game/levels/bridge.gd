extends Node2D

@export var triggers: Array[Node2D]
@export var untriggers: Array[Node2D]

@export var one_shot: bool = true
var shoted: bool = false
@export var from_rotation_degrees: int = 0
@export var to_rotation_degrees: int = 90
@export var to_transition_time: float = 3.0
@export var from_transition_time: float = 3.0
@onready var changed_player = $ChangedAudioStreamPlayer

var is_open: bool = false

func _ready():
	rotation = deg_to_rad(from_rotation_degrees)
	for trigger in triggers:
		trigger.changed.connect(handle)
	for trigger in untriggers:
		trigger.changed.connect(handle)
	handle(0)

var trans_tween: Tween
@onready var last_target: float = from_transition_time

func handle(value):
	if shoted:
		return
	var open: bool = true
	for trigger in triggers:
		if not trigger.value:
			open = false
	for untrigger in untriggers:
		if untrigger.value:
			open = false
	
	if get_tree():
		if trans_tween:
			trans_tween.stop()
		trans_tween = get_tree().create_tween()
		
		var target = deg_to_rad(to_rotation_degrees) if open else deg_to_rad(from_rotation_degrees)
		trans_tween.tween_property(self, "rotation", target, (to_transition_time if open else from_transition_time * ((from_rotation_degrees - rotation_degrees)/(from_rotation_degrees - to_rotation_degrees))))
		
		if last_target != target:
			changed_player.play()
		last_target = target
		if open and one_shot:
			shoted = true
