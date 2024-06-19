extends Node

@export var value: bool = false:
	set(val):
		#print(val)
		value = val
		if not is_node_ready(): await ready
		changed.emit(value)

signal changed(val)


func _ready():
	changed.emit(value)
