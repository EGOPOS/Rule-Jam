extends Node

@export var next_level_path: String
@export var previos_level_path: String

@export var collectable_item: CollectableItem
@export var geek: Geek

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	if collectable_item:
		collectable_item.collected.connect(on_collectable_item_collected)
	geek.died.connect(on_geek_died)
	
	Fade.fade_in()

func on_geek_died():
	GameManager.deaths += 1
	GameManager.transitions += 1
	await Fade.fade_out().finished
	
	if previos_level_path:
		get_tree().change_scene_to_file(previos_level_path)
	else:
		get_tree().reload_current_scene()

func on_collectable_item_collected():
	GameManager.transitions += 1
	await Fade.fade_out().finished
	
	if next_level_path:
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file("res://game/userInterface/main_menu.tscn")

func _input(event):
	if Input.is_action_just_pressed("restart"):
		await Fade.fade_out(0.5).finished
		get_tree().reload_current_scene()
