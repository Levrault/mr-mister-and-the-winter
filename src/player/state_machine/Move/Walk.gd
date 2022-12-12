# meta-name: State
# meta-description: State of a State Machine
extends State
class_name PlayerWalkState

@export var max_speed := 2.0


var footstep_index := 0

@onready var timer := $Timer


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	if _parent.input_direction == Vector2.ZERO:
		_state_machine.transition_to("Move/Idle")
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)
	_parent.max_speed = max_speed
	owner.animation_player.play("walk")
	
	timer.timeout.connect(_on_Timeout)
	timer.start()


func exit() -> void:
	_parent.exit()
	timer.stop()
	timer.timeout.disconnect(_on_Timeout)


func _on_Timeout() -> void:
	footstep_index += 1
	if footstep_index >= owner.footstep_sfx.size():
		footstep_index = 0
	owner.footstep_sfx[footstep_index].play()
