extends Node2D

class_name State

var change_state
var persistant_state

func setup(arg_change_state, arg_persistant_state):
    self.change_state = arg_change_state
    self.persistant_state = arg_persistant_state

func set_inputmap():
    pass