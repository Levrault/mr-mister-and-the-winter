# meta-name: State
# meta-description: State of a State Machine
extends State

var has_answered_question := true


func unhandled_input(event: InputEvent) -> void:
	if owner.object_to_interact.is_collectable:
		return
	
	if event.is_action_pressed("interact"):
		Events.dialogue_finished.emit()
		owner.object_to_interact.stop_interaction()
		_state_machine.transition_to("Move/Idle")
		return


func physics_process(_delta: float) -> void:
	return


func enter(_msg: Dictionary = {}) -> void:
	owner.object_to_interact.start_interaction()
	owner.animation_player.play("idle")

	if  owner.object_to_interact.is_collectable:
		Events.dialogue_question_answered.connect(_on_Dialogue_question_answered)


func exit() -> void:
	has_answered_question = false


func _on_Dialogue_question_answered(answer) -> void:
	Events.dialogue_question_answered.disconnect(_on_Dialogue_question_answered)
	owner.object_to_interact.stop_interaction()
	
	if answer:
		_state_machine.transition_to("Move/Idle/Take", { id = owner.object_to_interact.id})
		return
	_state_machine.transition_to("Move/Idle")
