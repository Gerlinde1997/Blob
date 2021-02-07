extends Node2D

func _on_Left_Down_body_entered(_body):
	# to up left grass
	PlayerGlobalVariables.animation = "IdleDown"
	PlayerGlobalVariables.pos = Vector2(320, 25)
	SceneChanger.goto_scene("res://Grass.tscn")


func _on_Left_Up_body_entered(_body):
	# to down left grass
	PlayerGlobalVariables.animation = "IdleUp"
	PlayerGlobalVariables.pos = Vector2(320, 999)
	SceneChanger.goto_scene("res://Grass.tscn")
