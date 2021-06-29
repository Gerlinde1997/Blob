extends Control

func _input(event):
	if event.is_action_pressed("back"):
		_on_Back_pressed()


func _on_Back_pressed():
	SceneChanger.goto_scene("res://Start.tscn")
