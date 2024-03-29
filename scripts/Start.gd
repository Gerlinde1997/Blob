extends Control

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

func _input(event):
	if event.is_action_pressed("start"):
		_on_Start_wsad_pressed()
	if event.is_action_pressed("help"):
		_on_Help_pressed()


func _on_Start_wsad_pressed():
	GlobalVariables.chosen_input = "wsad"
	SceneChanger.goto_scene("res://Grass.tscn")


func _on_Start_click_move_pressed():
	GlobalVariables.chosen_input = "click_move"
	SceneChanger.goto_scene("res://Grass.tscn")


func _on_Help_pressed():
	SceneChanger.goto_scene("res://Instructions.tscn")
