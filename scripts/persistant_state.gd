extends Node2D

class_name PersistantState

var state
var state_factory

func _ready():
    state_factory = StateFactory.new()
    change_state("walking")

func set_inputmap():
    state.set_inputmap()

func change_state(new_state_name):
    if state != null:
        state.queue_free()
    state = state_factory.get_state(new_state_name).new()
    state.setup(funcref(self, "change_state"), self)
    state.name = "current_state"
    add_child(state)