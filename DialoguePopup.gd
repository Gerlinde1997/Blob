extends PopupDialog

var mob_name setget set_name
var dialogue setget set_dialogue
var answers setget set_answers

var mob

func set_name(name):
	mob_name = name
	$ColorRect/MobName.text = name

func set_dialogue(mob_text):
	dialogue = mob_text
	$ColorRect/Dialogue.text = mob_text

func set_answers(player_text):
	answers = player_text
	$ColorRect/Answers.text = player_text

func open():
	get_tree().paused = true
	popup()
	$AnimationPlayer.playback_speed = 60.0 / dialogue.length()
	$AnimationPlayer.play("ShowDialogue")

func close():
	get_tree().paused = false
	hide()

func _ready():
	set_process_input(false)

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_A:
			set_process_input(false)
			mob.conversation("A")
		if event.scancode == KEY_B:
			set_process_input(false)
			mob.conversation("B")

func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
