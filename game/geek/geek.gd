class_name Geek extends RigidBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var sitting_collision = $SittingCollisionShape2D
@onready var handing_collision = $HandingCollisionShape2D2
@onready var marker = $Marker2D

func _ready():
	animation_player.play("sitting")

func hand(cursor_position):
	#sprite.position = lerp(sprite.position, sprite.to_local(cursor_position), get_physics_process_delta_time() * 8.0)
	#sitting_collision.position = lerp(sitting_collision.position, sprite.to_local(cursor_position), get_physics_process_delta_time() * 8.0)
	#handing_collision.position = lerp(handing_collision.position, sprite.to_local(cursor_position), get_physics_process_delta_time() * 8.0)
	#get_tree().create_tween().tween_property(self, "position", -marker.position, 0.3)
	get_tree().create_tween().tween_property(sprite, "position", -marker.position + sprite.to_local(cursor_position)+Vector2(0, 50), 0.3)
	get_tree().create_tween().tween_property(sitting_collision, "position", -marker.position + sitting_collision.to_local(cursor_position)+Vector2(0, 50), 0.3)
	get_tree().create_tween().tween_property(handing_collision, "position", -marker.position + handing_collision.to_local(cursor_position)+Vector2(0, 50), 0.3)
	animation_player.play("handing")

func sit():
	get_tree().create_tween().tween_property(sprite, "position", Vector2(), 0.3)
	get_tree().create_tween().tween_property(sitting_collision, "position", Vector2(-0.5, 11), 0.3)
	get_tree().create_tween().tween_property(handing_collision, "position", Vector2(-0.5, 0), 0.3)
	animation_player.play("sitting")
