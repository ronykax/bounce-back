extends RigidBody2D
class_name Projectile

var ttl := 4.0 # seconds

func _process(delta: float) -> void:
	if global_position.x > 1024 or global_position.x < 0:
		queue_free()
	
	if global_position.y > 768 or global_position.y < 0:
		queue_free()

	await get_tree().create_timer(ttl).timeout
	queue_free()
