extends Control

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

const RED = Color(1, 0, 0, 0.2)
const ORANGE = Color(0.9, 0.5, 0, 0.2)
const YELLOW = Color(1, 1, 0, 0.2)
const GREEN = Color(0.5, 1, 0, 0.2)
const BLUE = Color(0, 0.5, 0.9, 0.2)
const PURPLE = Color(0.45, 0, 1, 0.2)

var npc_popup_hidden
var color_name_list = []
var collected = 0

onready var count = $Background/Count
onready var color_rects = $Colors.get_children()
onready var shovel = $Background/Shovel

	
func _ready():
	set_colors()
	get_color_names()


func _process(_delta):
	update_colors()
	update_coin_count()
	update_shovel()

	if GlobalVariables.colors.size() == 6 and npc_popup_hidden == true:
		SceneChanger.goto_scene("res://End.tscn")


func set_colors():
	$Colors/Red.color = RED
	$Colors/Orange.color = ORANGE 
	$Colors/Yellow.color = YELLOW
	$Colors/Green.color = GREEN
	$Colors/Blue.color = BLUE
	$Colors/Purple.color = PURPLE


func get_color_names():
	for child in color_rects:
		color_name_list.append(child.get_name())

func update_colors():
	for color_name in color_name_list:
		if color_name in GlobalVariables.colors:
			var node = "Colors/{name}".format({"name": color_name})
			get_node(node).color.a = 1		

func update_coin_count():
	var amount = GlobalVariables.coins
	count.text = str(amount)

func update_shovel():
	if GlobalVariables.picked_shovel == null:
		shovel.modulate = Color(1, 1, 1, 0.5)
	else:
		shovel.modulate = Color(1, 1, 1, 1)
