extends CharacterBody2D

var speed = 1
var sl = false

func _physics_process(delta):
	if sl == true:
		#if Input.is_action_just_pressed("grab"):
		var direction = get_global_mouse_position() - global_position
		if direction:
			if sl == true:
				velocity = speed * direction
			if sl == false:
				velocity.x = move_toward(velocity.x, 0, speed)
				velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()

#func _on_button_mouse_entered():
	#sl = true
	#print(sl)

#func _on_button_mouse_exited():
	#sl = false
	#print(sl)

func _on_button_button_down():
	sl = true


func _on_button_button_up():
	sl = false
	print("F#CK")
