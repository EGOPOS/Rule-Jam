extends Node

var action_callables = {
	#"right": "",
	#"left": "",
	#"jump": "",
}

var _input_buffer: Array[String]
var _buffer_save_inputs_time: float = 0.05

func _input(event):
	if event.is_action_type():
		for action in action_callables.keys():
			if event.is_action(action):
				_input_buffer.append(action)
				get_tree().create_timer(_buffer_save_inputs_time).timeout.connect( Callable(func(action: String):
					_input_buffer.remove_at(_input_buffer.rfind(action))
				).bind(action) )

func is_action_in_buffer(action: String):
	if _input_buffer.find(action) != -1:
		return true
	return false
