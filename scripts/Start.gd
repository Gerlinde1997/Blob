extends Control

func _on_Start_pressed():
	SceneChanger.goto_scene("res://Grass.tscn")

func _on_Help_pressed():
	SceneChanger.goto_scene("res://Instructions.tscn")