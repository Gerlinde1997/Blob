extends Area2D

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

onready var player = $"../Player"


func _on_Shovel_body_entered(body):
	if body == player:
		GlobalVariables.picked_shovel = self.get_path()
		self.queue_free()
