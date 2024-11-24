extends CharacterBody2D
class_name Enemy

@export var player_info_res: PlayerInfo
@export var health_res: Health

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var audio_hurt: AudioStreamPlayer2D = $Sounds/Hurt
@onready var audio_death: AudioStreamPlayer2D = $Sounds/Death
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

#var speed := 200.0
var speed := 24.0

var health := 2

func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	var target_position = player_info_res.player_position
	var direction = (target_position - position).normalized()
	
	velocity = direction * speed
	
	move_and_collide(velocity * _delta)
	
	look_at(player_info_res.player_position)
	rotation += deg_to_rad(45)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		audio_hurt.play()
		cpu_particles_2d.emitting = true
		health_res.hearts -= 1
		queue_free()

	if body is Projectile:
		audio_hurt.play()
		cpu_particles_2d.emitting = true
		health -= 1

#func _on_cpu_particles_2d_finished() -> void:
	#collision_polygon_2d.disabled = true
	#audio_death.play()
	#
	#await get_tree().create_timer(2).timeout
	#queue_free()
