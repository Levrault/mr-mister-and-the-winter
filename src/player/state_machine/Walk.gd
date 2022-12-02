# meta-name: State
# meta-description: State of a State Machine
extends State
class_name PlayerWalkState

@export var max_speed := 5.0


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	if _parent.input_direction == Vector2.ZERO:
		_state_machine.transition_to("Move/Idle")
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)
	_parent.max_speed = max_speed


func exit() -> void:
	_parent.exit()
