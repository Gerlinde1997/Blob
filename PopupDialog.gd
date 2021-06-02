extends WindowDialog

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("answer_1"):
		popup()
	if Input.is_action_just_pressed("answer_2"):
		hide()
