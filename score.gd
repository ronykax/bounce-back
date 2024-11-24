extends MarginContainer

var score := 0.0

func _process(delta: float) -> void:
	score += delta
	$Label.text = "%03d" % int(score)
