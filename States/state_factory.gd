extends Node2D

class_name StateFactory

var states: Dictionary


func _init() -> void:
	states = {
		"idle" : IdleState,
		"running" : RunningState,
		"inflate" : InflateState
	}


func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		push_error("No state '" + state_name + "' in state factory.")
