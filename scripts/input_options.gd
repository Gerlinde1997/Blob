extends Control

func _on_input_wsad_toggled(pressed):
	if pressed:
		print("wsad: ", pressed)
		#wsad process in player -> funcref enzo
		#clikc_move pressed = false


func _on_input_click_move_toggled(pressed):
	if pressed:
		print("clickmove: ", pressed)
