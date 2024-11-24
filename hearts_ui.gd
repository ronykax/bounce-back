extends MarginContainer

@export var heart_texture: Texture2D
@export var health_res: Health

@onready var h_box_container: HBoxContainer = $HBoxContainer

func _process(delta: float) -> void:
	for child in h_box_container.get_children():
		child.queue_free()

	for i in range(health_res.hearts):
		var heart = TextureRect.new()
		heart.texture = heart_texture
		h_box_container.add_child(heart)
