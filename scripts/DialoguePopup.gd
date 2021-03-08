extends PopupDialog

var npc_name setget set_name
var dialogue_text setget set_dialogue
var answers setget set_answers

var npc

func set_name(name):
	npc_name = name
	$ColorRect/NpcName.text = name

func set_dialogue(mob_text):
	dialogue_text = mob_text
	$ColorRect/Dialogue.text = mob_text

func set_answers(player_text):
	answers = player_text
	$ColorRect/Answers.text = player_text

func open():
	set_inputmap_dialogue()
	get_tree().paused = true
	popup()
	$AnimationPlayer.playback_speed = 60.0 / dialogue_text.length()
	$AnimationPlayer.play("ShowDialogue")

func close():
	get_tree().paused = false
	set_inputmap_walking()
	hide()

func _ready():
	set_inputmap_walking()
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

func add_action_and_event(new_action, event):
	InputMap.add_action(new_action)
	InputMap.action_add_event(new_action, event)

func set_inputmap_dialogue():
	var non_active_actions = ["move_up", "move_down", "move_right", "move_left", "npc_interact"]
	var state_actions = ["answer_1", "answer_2"]
	for action in non_active_actions:
		if InputMap.has_action(action):
			InputMap.erase_action(action)
	
	for new_action in state_actions:
		if not InputMap.has_action(new_action):

			if new_action == "answer_1":
				var event = InputEventKey.new()
				event.scancode = KEY_1
				add_action_and_event(new_action, event)
			
			if new_action == "answer_2":
				var event = InputEventKey.new()
				event.scancode = KEY_2
				add_action_and_event(new_action, event)

func set_inputmap_walking():
	var non_active_actions = ["answers_1", "answers_2"]
	var state_actions = ["move_up", "move_down", "move_right", "move_left", "npc_interact"]

	for action in non_active_actions:
		if InputMap.has_action(action):
			InputMap.erase_action(action)
	
	for new_action in state_actions:
		if not InputMap.has_action(new_action):

			if new_action == "move_up":
				var event = InputEventKey.new()
				event.scancode = KEY_W
				add_action_and_event(new_action, event)
			
			elif new_action == "move_down":
				var event = InputEventKey.new()
				event.scancode = KEY_S
				add_action_and_event(new_action, event)
			
			elif new_action == "move_right":
				var event = InputEventKey.new()
				event.scancode = KEY_D
				add_action_and_event(new_action, event)
			
			elif new_action == "move_left":
				var event = InputEventKey.new()
				event.scancode = KEY_A
				add_action_and_event(new_action, event)
			
			elif new_action == "npc_interact":
				var event = InputEventKey.new()
				event.scancode = KEY_SPACE
				add_action_and_event(new_action, event)