extends Control

var npc_name setget set_name
var dialogue_text setget set_dialogue
var answers setget set_answers

var npc
onready var hud = $"../HUD"
onready var player = $"../../Player"

func set_name(name):
	npc_name = name
	$ColorRect/NpcName.text = name

func set_dialogue(npc_text):
	dialogue_text = npc_text
	$ColorRect/Dialogue.text = npc_text

func set_answers(player_text):
	answers = player_text
	$ColorRect/Answers.text = player_text

func open():
	npc.walk = false
	hud.npc_popup_hidden = false
	player.moveTarget = player.position
	player.set_physics_process(false)
	set_visible(true)
	$AnimationPlayer.playback_speed = 60.0 / dialogue_text.length()
	$AnimationPlayer.play("ShowDialogue")

func close():
	npc.walk = true
	hud.npc_popup_hidden = true
	player.set_physics_process(true)
	set_visible(false)

func _ready():
	set_visible(false)
	set_process_input(false)

func _input(event):
	if event.is_action_pressed("answer_1"):
		set_process_input(false)
		npc.conversation(1)
	if event.is_action_pressed("answer_2"):
		set_process_input(false)
		npc.conversation(2)

func _on_AnimationPlayer_animation_finished(_anim_name):
	set_process_input(true)
