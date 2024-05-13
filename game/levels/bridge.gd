extends Node2D

@export var triggers: Array[Node2D]
@export var one_shot: bool = true
var shoted: bool = false
@export var from_rotation_degrees: int = 0
@export var to_rotation_degrees: int = 90
@export var to_transition_time: float = 3.0
@export var from_transition_time: float = 3.0

func _ready():
	rotation = deg_to_rad(from_rotation_degrees)
	for trigger in triggers:
		trigger.changed.connect(handle)

func handle(value):
	if shoted:
		return
	var open: bool = true
	for trigger in triggers:
		if not trigger.value:
			open = false
	
	get_tree().create_tween().tween_property(self, "rotation", deg_to_rad(to_rotation_degrees) if open else deg_to_rad(from_rotation_degrees), (to_transition_time if open else from_transition_time * ((from_rotation_degrees - rotation_degrees)/(from_rotation_degrees - to_rotation_degrees))))
	if one_shot:
		shoted = true
