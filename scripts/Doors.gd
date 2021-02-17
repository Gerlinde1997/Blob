extends Node

# Doors in Grass
func _on_Up_left_door_body_entered(_body):
	# to down left stone
	GlobalVariables.animation = "IdleUp"
	GlobalVariables.pos = Vector2(320, 871)
	SceneChanger.goto_scene("res://Stone.tscn")


func _on_Down_left_door_body_entered(_body):
	# to up left stone
	GlobalVariables.animation = "IdleDown"
	GlobalVariables.pos = Vector2(320, -39)
	SceneChanger.goto_scene("res://Stone.tscn")

# Doors in Stone
func _on_Left_Down_body_entered(_body):
	# to up left grass
	GlobalVariables.animation = "IdleDown"
	GlobalVariables.pos = Vector2(320, 25)
	SceneChanger.goto_scene("res://Grass.tscn")


func _on_Left_Up_body_entered(_body):
	# to down left grass
	GlobalVariables.animation = "IdleUp"
	GlobalVariables.pos = Vector2(320, 999)
	SceneChanger.goto_scene("res://Grass.tscn")
