extends CanvasLayer

@onready var start_button = %StartButton
@onready var settings_button = %SettingsButton
@onready var exit_button = %ExitButton

@onready var settings = %Settings

@export var started_scene: PackedScene

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var start = func():
		#get_tree().get_root().add_child(preload("res://game/userInterface/user_interface.tscn").instantiate())
		get_tree().change_scene_to_packed(started_scene)

	start_button.pressed.connect(start)
	var settings = func():
		self.settings.visible = !self.settings.visible
	settings_button.pressed.connect(settings)
	exit_button.pressed.connect(get_tree().quit)
