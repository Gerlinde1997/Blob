extends Button


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_Close_button_pressed()


func _on_Close_button_pressed():
	get_tree().quit()
