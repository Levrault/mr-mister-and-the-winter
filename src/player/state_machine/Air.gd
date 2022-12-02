extends State

@export var jump_velocity_default = 8

var jump_velocity := jump_velocity_default


func unhandled_input(_event: InputEvent):
	return


func physics_process(delta):
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Idle")
		return
	
	owner.velocity.y -= owner.gravity * delta
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}):
	if "impulse" in msg:
		owner.velocity.y = jump_velocity
		return


func exit():
	return
