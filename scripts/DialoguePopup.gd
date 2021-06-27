extends Control

var npc_name setget set_name
var dialogue_text setget set_dialogue
var answer_1 setget set_answer_1
var answer_2 setget set_answer_2

var npc
onready var hud = $"../HUD"
onready var player = $"../../Player"

func set_name(name):
	npc_name = name
	$ColorRect/NpcName.text = name

func set_dialogue(npc_text):
	dialogue_text = npc_text
	$ColorRect/Dialogue.text = npc_text

func set_answer_1(player_text_1):
	answer_1 = player_text_1
	$ColorRect/Answer_1.text = player_text_1

func set_answer_2(player_text_2):
	answer_2 = player_text_2
	$ColorRect/Answer_2.text = player_text_2

func open():
	hud.npc_popup_hidden = false
	player.set_physics_process(false)
	set_visible(true)
	$AnimationPlayer.playback_speed = 60.0 / dialogue_text.length()
	$AnimationPlayer.play("ShowDialogue")

func close():
	hud.npc_popup_hidden = true
	player.set_physics_process(true)
	set_visible(false)

func _ready():
	set_visible(false)
	set_process_input(false)

func _input(event):
	if event.is_action_pressed("answer_1"):
		_on_Answer_pressed(1)
	if event.is_action_pressed("answer_2"):
		_on_Answer_pressed(2)

func _on_Answer_pressed(answer):
	set_process_input(false)
	npc.conversation(answer)

func _on_AnimationPlayer_animation_finished(_anim_name):
	set_process_input(true)
