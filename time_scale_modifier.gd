extends Node
class_name TimeScaleModifier

func start_slowmo():
	Engine.time_scale = 0.25

func end_slowmo():
	Engine.time_scale = 1.0
