extends Control

func _on_Start_pressed():
	SceneChanger.goto_scene("res://Grass.tscn")

func _on_Help_pressed():
	SceneChanger.goto_scene("res://Instructions.tscn")

func _input(event):
	if event.is_action_pressed("start"):
		_on_Start_pressed()
	if event.is_action_pressed("help"):
		_on_Help_pressed()