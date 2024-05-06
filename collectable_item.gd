class_name CollectableItem extends Area2D

enum Items {Test}

signal collected

func _ready():
	body_entered.connect(func(body):
		if body is Geek:
			collected.emit()
	)

