extends Node

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

var npc_talk_data: Dictionary


func _ready():
	pass
	#npc_talk_data = LoadData("res://scripts/Data/npcTalkData.json")


func LoadData(file_path):
	var json_data
	var file_data = File.new()

	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	return json_data.result

