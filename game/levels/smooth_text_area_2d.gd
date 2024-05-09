extends Area2D

@export_multiline var text: String = ""
@export var smoothing_time: float = 2.0
@onready var label = %Label

func _ready():
	label.modulate.a = 0
	var counter: int = 0
	var char_counter: int = 0
	var new_text: String = text
	
	#for c in text:
		#if c != "\n":
			#char_counter += 1
		#else:
			#char_counter = 0
		#
		#if char_counter > 15:
			#new_text[counter] = "\n"
			#print(new_text)
			#char_counter = 0
		#
		#counter += 1
	
	label.text = new_text
	body_entered.connect(func(body):
		if body is Cursor:# or body is Geek:
			if label.modulate.a == 0:
				get_tree().create_tween().tween_property(label, "modulate:a", 1.0, smoothing_time)
	)
