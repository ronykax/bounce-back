extends Control

@export var health_res: Health

func _process(delta: float) -> void:
	if health_res.hearts <= 0:
		health_res.hearts = 3
		get_tree().reload_current_scene()
	
	if $UI.show_window == true:
		Engine.time_scale = 0.1
	elif $UI.show_window == false:
		Engine.time_scale = 1.0
