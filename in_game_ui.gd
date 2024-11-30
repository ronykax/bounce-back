extends Control

@export var blood_res: Blood

@onready var information_window: Control = $InformationWindow
@onready var blood: TextureRect = $Blood

var show_window := false

func _ready() -> void:
	blood.self_modulate = Color(1, 1, 1, 0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		show_window = !show_window
	
	if show_window == true:
		information_window.visible = true
	else:
		information_window.visible = false

	# blood effefct
	if blood_res.show_blood == true:
		blood.self_modulate = Color(1, 1, 1, 1)
		#blood.self_modulate.lerp(Color(1, 1, 1, 1), delta * 10.0)
		
		await get_tree().create_timer(1.5).timeout
		
		blood_res.show_blood = false
	elif blood_res.show_blood == false:
		blood.self_modulate = Color(1, 1, 1, 0)

func _on_texture_button_pressed() -> void:
	show_window = false
