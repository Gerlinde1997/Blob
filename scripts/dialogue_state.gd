extends State

class_name DialogueState

var non_active_actions = ["move_up", "move_down", "move_right", "move_left", "npc_interact"]
var state_actions = ["answer_1", "answer_2"]

#func _ready():
func _enter_tree():
    set_inputmap()

func _process(_delta):
    var dialoguePopup_open = $"../../CanvasLayer/DialoguePopup".opened
    if not dialoguePopup_open:
        change_state.call_func("walking")

func set_inputmap():
    for action in non_active_actions:
        if InputMap.has_action(action):
            InputMap.erase_action(action)
    
    for new_action in state_actions:
        if not InputMap.has_action(new_action):

            if new_action == "answer_1":
                var event = InputEventKey.new()
                event.scancode = KEY_1
                InputMap.add_action(new_action)
                InputMap.action_add_event(new_action, event)
            
            if new_action == "answer_2":
                var event = InputEventKey.new()
                event.scancoe = KEY_2
                InputMap.add_action(new_action)
                InputMap.action_add_event(new_action, event)         
