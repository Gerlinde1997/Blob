extends Node2D

func _ready():
	if randi() % 2 == 0:
		$ColorRect.color = Color(0.99, 0.80, 0.01, 1)
	else:
		$ColorRect.color = Color(0.01, 0.67, 0.99, 1)
