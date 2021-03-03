extends State

class_name WalkingState

var non_active_actions = ["answers_1", "answers_2"]
var state_actions = ["move_up", "move_down", "move_right", "move_left", "npc_interact"]

func _ready():
    set_inputmap()

func set_inputmap():
    for action in non_active_actions:
        if InputMap.has_action(action):
            InputMap.erase_action(action)
    
    for new_action in state_actions:
        if not InputMap.has_action(new_action):

            if new_action == "move_up":
                var event = InputEventKey.new()
                event.scancode = KEY_UP
                InputMap.add_action(new_action)
                InputMap.action_add_event(new_action, event)
            
            elif new_action == "move_down":
                var event = InputEventKey.new()
                event.scancode = KEY_DOWN
                InputMap.add_action(new_action)
                InputMap.action_add_event(new_action, event)
            
            elif new_action == "move_right":
                var event = InputEventKey.new()
                event.scancode = KEY_DIRECTION_R
                InputMap.add_action(new_action)
                InputMap.action_add_event(new_action, event)
            
            elif new_action == "move_left":
                var event = InputEventKey.new()
                event.scancode = KEY_DIRECTION_L
                InputMap.add_action(new_action)
                InputMap.action_add_event(new_action, event)