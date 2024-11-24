extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $"../SpawnArea/CollisionShape2D"
@onready var enemies: Node2D = $Enemies
@onready var spawn_timer: Timer = $Timer

var grid_size = 10

const enemy_scene = preload("res://enemy.tscn")

func spawn_enemy() -> void:
	var size = collision_shape_2d.shape.get_rect().size
	
	var cell_width = size.x / grid_size
	var cell_height = size.y / grid_size
	
	var random_position = position + Vector2(
		randi() % grid_size * cell_width - size.x / 2 + cell_width / 2,
		randi() % grid_size * cell_height - size.y / 2 + cell_height / 2
	)
	
	var random_global_position = collision_shape_2d.to_global(random_position)
	
	var new_enemy = enemy_scene.instantiate()
	new_enemy.position = random_global_position

	enemies.add_child(new_enemy)

func _on_timer_timeout() -> void:
	if enemies.get_child_count() < 4:
		spawn_enemy()
