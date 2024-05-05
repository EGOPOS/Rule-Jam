class_name Grabbing extends RigidBody2D

func grab(grab_position):
	gravity_scale = 0

func ungrab():
	gravity_scale = 1
	freeze = false
	sleeping = false
