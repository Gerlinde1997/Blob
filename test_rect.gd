extends Control

func _ready():
	visible = false

func _process(_delta):
	if Input.is_action_just_pressed("answer_1"):
		visible = true
	if Input.is_action_just_pressed("answer_2"):
		visible = false
