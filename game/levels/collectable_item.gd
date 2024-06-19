class_name CollectableItem extends Area2D

signal collected
@onready var animation_player = $AnimationPlayer

func _ready():
	body_entered.connect(func(body):
		if body is Geek:
			collected.emit()
	)
	animation_player.play("loop")

