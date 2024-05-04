extends Camera2D

@export var cursor: Cursor
@export var smoothing: float = 1

var last_mouse_time: int

func _ready():
	global_position = cursor.global_position

func _process(delta):
	if (global_position - cursor.global_position).length() > 20.0:
		global_position = global_position.lerp(cursor.global_position, delta * (1/smoothing)*10)
		var new_mouse_position = lerp(get_window().get_mouse_position(), Vector2(get_viewport().size/2), delta * (1/smoothing)*10)
		DisplayServer.warp_mouse(Vector2i(new_mouse_position))
	
func _input(event):
	if event is InputEventMouseMotion:
		last_mouse_time = Time.get_unix_time_from_system()
