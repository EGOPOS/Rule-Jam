extends Node

@export var next_level: PackedScene
@export var previos_level: PackedScene

@export var collectable_item: CollectableItem
@export var geek: Geek

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	if collectable_item:
		collectable_item.collected.connect(on_collectable_item_collected)
	geek.died.connect(on_geek_died)

func on_geek_died():
	if previos_level:
		get_tree().change_scene_to_packed(previos_level)
	else:
		get_tree().reload_current_scene()

func on_collectable_item_collected():
	if next_level:
		get_tree().change_scene_to_packed(next_level)
	else:
		get_tree().change_scene_to_file("res://game/userInterface/main_menu.tscn")

func _input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
