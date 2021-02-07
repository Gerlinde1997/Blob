extends Node2D

func _on_Up_left_door_body_entered(_body):
	# to down left stone
	PlayerGlobalVariables.animation = "IdleUp"
	PlayerGlobalVariables.pos = Vector2(320, 871)
	SceneChanger.goto_scene("res://Stone.tscn")


func _on_Down_left_door_body_entered(_body):
	# to up left stone
	PlayerGlobalVariables.animation = "IdleDown"
	PlayerGlobalVariables.pos = Vector2(320, -39)
	SceneChanger.goto_scene("res://Stone.tscn")
