extends Node

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

func _on_Up_left_door_body_entered(_body):
	# to down left stone
	GlobalVariables.animation = "IdleUp"
	GlobalVariables.pos = Vector2(320, 871)
	SceneChanger.goto_scene("res://Stone.tscn")


func _on_Left_Down_body_entered(_body):
	# to up left grass
	GlobalVariables.animation = "IdleDown"
	GlobalVariables.pos = Vector2(320, 25)
	SceneChanger.goto_scene("res://Grass.tscn")
