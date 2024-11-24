extends Control

@onready var information_window: Control = $InformationWindow

var show_window := false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		show_window = !show_window
	
	if show_window == true:
		information_window.visible = true
	else:
		information_window.visible = false

func _on_texture_button_pressed() -> void:
	show_window = false
