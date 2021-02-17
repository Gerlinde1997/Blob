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
	# A key
	if Input.is_action_just_pressed("answer_a"):
		set_process_input(false)
		npc.conversation("A")
	# B key
	if Input.is_action_just_pressed("answer_b"):
		set_process_input(false)
		npc.conversation("B")

func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
