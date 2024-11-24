extends CharacterBody2D
class_name Player

@export var health_res: Health

var speed = 600.0
var jump_velocity = -450.0

@onready var weapon_holder: Node2D = $PivotPoint/WeaponHolder
@onready var projectile_spawn_point: Node2D = $PivotPoint/WeaponHolder/ProjectileSpawnPoint
@onready var pivot_point: Node2D = $PivotPoint
@onready var cpu_particles_2d: CPUParticles2D = $PivotPoint/WeaponHolder/ProjectileSpawnPoint/CPUParticles2D
@onready var audio_launch: AudioStreamPlayer2D = $Sounds/Launch
@onready var audio_hurt: AudioStreamPlayer2D = $Sounds/Hurt

@export var player_info_res: PlayerInfo

const projectile_scene := preload("res://projectile.tscn")

var should_launch := false
var can_shoot := true

func _process(delta: float) -> void:
	can_shoot = true if Engine.time_scale == 1 else false
	move_rpg(delta)

	if Input.is_action_just_pressed("shoot"):
		should_launch = true

func _physics_process(delta: float) -> void:
	move_around(delta)
	projectile_launcher()

	player_info_res.player_position = global_position

func move_around(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = lerp(velocity.x, direction * speed, delta * 10.0)
	else:
		velocity.x = lerp(velocity.x, 0.0, delta * 10.0)

	move_and_slide()

func move_rpg(delta: float):
	var mouse_pos = get_global_mouse_position()
	pivot_point.look_at(mouse_pos)

func projectile_launcher():
	if should_launch == true and can_shoot == true:
		audio_launch.play()

		var projectile = projectile_scene.instantiate() as RigidBody2D
		projectile.global_position = projectile_spawn_point.global_position
		get_tree().root.add_child(projectile)

		var mouse_pos = get_global_mouse_position()
		var body_pos = projectile.global_position
		var direction = (mouse_pos - body_pos).normalized()

		projectile.apply_impulse(550 * direction, Vector2.ZERO)
		cpu_particles_2d.emitting = true

		should_launch = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Projectile:
		audio_hurt.play()
		health_res.hearts -= 1