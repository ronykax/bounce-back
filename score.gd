extends MarginContainer

var score := 0.0

func _process(delta: float) -> void:
	score += delta * 10
	$Label.text = "%04d" % int(score)
