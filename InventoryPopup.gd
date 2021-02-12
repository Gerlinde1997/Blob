extends Popup

func open():
	get_tree().paused = true
	popup()

func close():
	get_tree().paused = false
	hide()


func _on_Button_toggled(button_pressed):
	if button_pressed:
		open()
	if !button_pressed:
		close()
