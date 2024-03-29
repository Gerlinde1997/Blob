extends Area2D

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

var dirt = preload("res://Sprites/hollow_64x64.png")
var mark = preload("res://Sprites/exclamation_mark32x32.png")
var shovel = preload("res://Sprites/mark_shovel.png")

onready var player = $"../../Player"


func _ready():
	if GlobalVariables.picked_hidden_coin != null:
		$Sprite.texture = dirt


func show_mark():
	$Sprite.texture = mark

	if GlobalVariables.picked_shovel != null:
		$Sprite.texture = shovel


func hide_mark():
	if $Sprite.texture == dirt:
		$Sprite.texture = dirt
	else:
		$Sprite.texture = null


func digging():
	if GlobalVariables.picked_shovel != null:
		GlobalVariables.picked_hidden_coin = self.get_path()
		GlobalVariables.coins += 1
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite.texture = dirt

func _on_Hollow_input_event(_vieuwport, event, _shape_idx):
	if GlobalVariables.chosen_input == "click_move":
		if event is InputEventMouseButton:
			digging()
