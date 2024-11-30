extends Control

@export var health_res: Health
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _process(delta: float) -> void:
	if health_res.hearts <= 0:
		health_res.hearts = 3
		get_tree().reload_current_scene()
	
	if $UI.show_window == true:
		Engine.time_scale = 0.0
	elif $UI.show_window == false:
		Engine.time_scale = 1.0
	
	if Input.is_action_just_pressed("mute_music"):
		if audio_stream_player_2d.playing:
			audio_stream_player_2d.stop()
		else:
			audio_stream_player_2d.play()
