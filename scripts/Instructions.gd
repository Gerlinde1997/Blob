extends Control

func _on_Play_pressed():
	SceneChanger.goto_scene("res://Grass.tscn")

func _on_Back_pressed():
	SceneChanger.goto_scene("res://Start.tscn")
