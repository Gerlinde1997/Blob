extends Control

onready var count = $Background/Count
onready var color_rects = $Colors.get_children()

var color_name_list = []

func update_coin_count():
	var amount = GlobalVariables.coins
	count.text = str(amount)

func get_color_names():
	for child in color_rects:
		color_name_list.append(child.get_name())

func set_color():
	for color_name in color_name_list:
		if color_name in GlobalVariables.colors:
			color_name.Color 

func _process(_delta):
	update_coin_count()



# func update_color():
# 	if 