extends Control

onready var count = $Background/Count
onready var color_rects = $Colors.get_children()

var color_name_list = []

var Red = Color(1, 0, 0, 0.2)
var	Orange = Color(0.9, 0.5, 0, 0.2)
var	Yellow = Color(1, 1, 0, 0.2)
var Green = Color(0.5, 1, 0, 0.2)
var Blue = Color(0, 0.5, 0.9, 0.2)
var Purple = Color(0.45, 0, 1, 0.2)

func set_colors():
	$Colors/Red.color = Red
	$Colors/Orange.color = Orange 
	$Colors/Yellow.color = Yellow
	$Colors/Green.color = Green
	$Colors/Blue.color = Blue
	$Colors/Purple.color = Purple

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

func _ready():
	set_colors()
	get_color_names()

func _process(_delta):
	update_colors()
	update_coin_count()