extends State

class_name WalkingState

var non_active_actions = ["answers_1", "answers_2"]
var state_actions = ["move_up", "move_down", "move_right", "move_left", "npc_interact"]

#func _ready():
func _enter_tree():
	set_inputmap()

# func _process(_delta):
#     # var dialoguePopup_open = $"../CanvasLayer/DialoguePopup".opened
#     # if dialoguePopup_open:
#     #     change_state.call_func("dialogue")
#     pass

func set_inputmap():
	for action in non_active_actions:
		if InputMap.has_action(action):
			InputMap.erase_action(action)
	
	for new_action in state_actions:
		if not InputMap.has_action(new_action):

			if new_action == "move_up":
				var event = InputEventKey.new()
				event.scancode = KEY_W
				InputMap.add_action(new_action)
				InputMap.action_add_event(new_action, event)
			
			elif new_action == "move_down":
				var event = InputEventKey.new()
				event.scancode = KEY_S
				InputMap.add_action(new_action)
				InputMap.action_add_event(new_action, event)
			
			elif new_action == "move_right":
				var event = InputEventKey.new()
				event.scancode = KEY_D
				InputMap.add_action(new_action)
				InputMap.action_add_event(new_action, event)
			
			elif new_action == "move_left":
				var event = InputEventKey.new()
				event.scancode = KEY_A
				InputMap.add_action(new_action)
				InputMap.action_add_event(new_action, event)
			
			elif new_action == "npc_interact":
				var event = InputEventKey.new()
				event.scancode = KEY_SPACE
				InputMap.add_action(new_action)
				InputMap.action_add_event(new_action, event)
