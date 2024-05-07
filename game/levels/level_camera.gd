extends Camera2D

@export var cursor: Cursor
@export var smoothing: float = 1

var last_mouse_time: int
var target_position: Vector2

func _ready():
	global_position = cursor.global_position
	target_position = get_window().size/2

func _physics_process(delta):
	if (global_position - cursor.global_position).length() > 20.0:
		global_position = global_position.lerp(cursor.global_position, delta * (1/smoothing)*10)
		var new_mouse_position = lerp(get_window().get_mouse_position(), target_position, delta * (1/smoothing)*10)
		DisplayServer.warp_mouse(lerp(get_window().get_mouse_position(), target_position, delta * (1/smoothing)*10))

func _input(event):
	if event is InputEventMouseMotion:
		last_mouse_time = Time.get_unix_time_from_system()

func _process(delta):
	if Vector2(get_window().size/2) != target_position:
		zoom *= Vector2(get_window().size/2)/target_position
		target_position = get_window().size/2
