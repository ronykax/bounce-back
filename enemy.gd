extends CharacterBody2D
class_name Enemy

@export var player_info_res: PlayerInfo
@export var health_res: Health
@export var get_hurt_res: GetHurt
@export var blood_res: Blood

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var audio_hurt: AudioStreamPlayer2D = $Sounds/Hurt
@onready var audio_death: AudioStreamPlayer2D = $Sounds/Death
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var collision_polygon_2d_area: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var sprite_2d: Sprite2D = $Sprite2D

#var speed := 200.0
#var speed := 24.0
var speed := 48.0

var health := 2

var alpha = 1.0
var kys := false

func _process(_delta: float) -> void:
	if health <= 0:
		kys = true

	if health >= 2:
		sprite_2d.modulate = Color(0.8, 0.204, 0.867, 1)
	elif health == 1:
		sprite_2d.modulate = Color(0.961, 0.533, 1, 1)

	if kys == true:
		collision_polygon_2d.disabled = true
		collision_polygon_2d_area.disabled = true

		alpha = lerp(alpha, 0.0, _delta * 10)
		sprite_2d.self_modulate = Color(1, 1, 1, alpha)
		
		if abs(alpha) < 0.01:
			queue_free()

func _physics_process(_delta: float) -> void:
	var target_position = player_info_res.player_position
	var direction = (target_position - position).normalized()
	
	velocity = direction * speed
	
	move_and_collide(velocity * _delta)
	
	look_at(player_info_res.player_position)
	rotation += deg_to_rad(35)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		audio_hurt.play()
		cpu_particles_2d.emitting = true
		health_res.hearts -= 1
		get_hurt_res.is_hurt_rn = true
		blood_res.show_blood = true
		#queue_free()
		kys = true

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
