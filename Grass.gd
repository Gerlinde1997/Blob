extends Node2D

onready var Global = $"/root/Global"



func _on_Button_pressed():
	Global.goto_scene("res://Stone.tscn")
