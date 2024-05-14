extends Node

var transitions: int = 0
var deaths: int = 0
var start_time: int
var end_time: int

func get_statistics():
	return {
		"spend_time": snapped((end_time - start_time) / 1000.0, 1.0),
		"deaths": deaths,
		"transitions": transitions
	}
#var 
