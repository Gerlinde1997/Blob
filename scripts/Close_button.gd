extends Button

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_Close_button_pressed()


func _on_Close_button_pressed():
	get_tree().quit()
