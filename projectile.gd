extends RigidBody2D
class_name Projectile

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

var alpha := 1.0

var kys := false

func _ready() -> void:
	timer.start()

func _process(delta: float) -> void:
	if global_position.x > 1024 or global_position.x < 0:
		queue_free()
	
	if global_position.y > 768 or global_position.y < 0:
		queue_free()

	if kys == true:
		collision_shape_2d.disabled = true

		alpha = lerp(alpha, 0.0, get_process_delta_time() * 10.0)
		sprite_2d.modulate = Color(1, 1, 1, alpha)

	if sprite_2d.modulate.a == 0.0:
		queue_free()

func _on_timer_timeout() -> void:
	kys = true
