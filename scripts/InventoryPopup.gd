extends Popup

var pickable = preload("res://inventory_coin.tscn")

func open():
	get_tree().paused = true
	popup()

func close():
	get_tree().paused = false
	hide()

func _on_Button_toggled(button_pressed):
	# With left mouse button
	if button_pressed:
		open()
	if !button_pressed:
		close()

#func add_item():
#	if not pickable in $ColorRect/GridContainer:
#		$ColorRect/GridContainer.add_child(pickable)
