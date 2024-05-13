extends Node

@export var value: bool = false:
	set(val):
		print(name)
		value = val
		if not is_node_ready(): await ready
		changed.emit(value)

signal changed(val)
