extends Control

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

func _input(event):
	if event.is_action_pressed("back"):
		_on_Back_pressed()


func _on_Back_pressed():
	SceneChanger.goto_scene("res://Start.tscn")
