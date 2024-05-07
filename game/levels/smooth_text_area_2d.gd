extends Area2D

@export_multiline var text: String = ""
@onready var label = %Label

func _ready():
	label.modulate.a = 0
	label.text = text
	body_entered.connect(func(body):
		if body is Cursor:# or body is Geek:
			if label.modulate.a == 0:
				get_tree().create_tween().tween_property(label, "modulate:a", 1.0, 2.0)
	)
