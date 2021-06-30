extends Control

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

onready var player = $"../../Player"


func _ready():
	set_visible(false)


func _input(event):
	if event.is_action_pressed("help"):
		if !self.visible:
			_on_Help_button_toggled(true)
		else:
			_on_Help_button_toggled(false)


func open():
	set_visible(true)
	get_tree().paused = true


func close():
	get_tree().paused = false
	set_visible(false)
	player.moveTarget = null

func _on_Help_button_toggled(button_pressed):
	if button_pressed:
		open()
	else:
		close()
	