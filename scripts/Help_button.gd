extends Button

func _on_Help_button_pressed():
	SceneChanger.goto_scene("res://Instructions.tscn")

func _input(event):
	if event.is_action_pressed("help"):
		_on_Help_button_pressed()