class_name StateFactory

var states

func _init():
    states = {
        "dialogue": DialogueState,
        "walking": WalkingState
}

func get_state(state_name):
    if states.has(state_name):
        return states.get(state_name)
    else:
        printerr("No state ", state_name, " in state factory!")