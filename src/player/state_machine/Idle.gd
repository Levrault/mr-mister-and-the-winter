# meta-name: State
# meta-description: State of a State Machine
extends State


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	if _parent.input_direction != Vector2.ZERO:
		_state_machine.transition_to("Move/Walk")
	_parent.physics_process(delta)


func enter(_msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return
