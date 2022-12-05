# meta-name: State
# meta-description: State of a State Machine
extends State


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		Events.stop_dialog.emit()
		owner.object_to_interact.stop_interaction()
		_state_machine.transition_to("Move/Idle")
		return


func physics_process(_delta: float) -> void:
	return


func enter(_msg: Dictionary = {}) -> void:
	owner.animation_player.play("idle")


func exit() -> void:
	return
