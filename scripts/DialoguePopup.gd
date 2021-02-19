extends PopupDialog

var npc_name setget set_name
var dialogue setget set_dialogue
var answers setget set_answers

var npc

func set_name(name):
	npc_name = name
	$ColorRect/NpcName.text = name

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

func _process(delta):
	# 1 key
	if Input.is_action_just_pressed("answer_1"):
		set_process_input(false)
		npc.conversation(1)
	# 2 key
	if Input.is_action_just_pressed("answer_2"):
		set_process_input(false)
		npc.conversation(2)

func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
