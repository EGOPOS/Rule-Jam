extends Grabbing

@onready var health_component = $HealthComponent
@onready var boom_hurt_area = $BoomHurtArea2D
@onready var animation_player = $AnimationPlayer

func _ready():
	health_component.health_end.connect(boom)
	boom_hurt_area.hurted.connect(
		func(area):
			var body = area.owner
			throw_body(body)
	)

func boom():
	for body in boom_hurt_area.get_overlapping_bodies():
		throw_body(body)
	animation_player.play("boom")
	await animation_player.animation_finished
	queue_free
	queue_free()

func throw_body(body):
	if body is RigidBody2D:# and body != self:
		await get_tree().physics_frame
		body.apply_central_impulse((body.global_position.direction_to(global_position)+Vector2.UP*3).normalized() * 75000)
		print(body)

