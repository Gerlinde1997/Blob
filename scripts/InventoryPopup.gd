extends Popup

func _on_invButton_toggled(button_pressed):
	# With left mouse button
	if button_pressed:
		popup()
	else:
		hide()

#func add_item():
#	if not pickable in $ColorRect/GridContainer:
#		$ColorRect/GridContainer.add_child(pickable)