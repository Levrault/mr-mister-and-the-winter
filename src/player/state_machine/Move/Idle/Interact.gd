# meta-name: State
# meta-description: State of a State Machine
extends State


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		Events.dialogue_finished.emit()
		owner.object_to_interact.stop_interaction()
		_state_machine.transition_to("Move/Idle")
		return


func physics_process(_delta: float) -> void:
	return


func enter(_msg: Dictionary = {}) -> void:
	owner.animation_player.play("idle")
	_state_machine.set_process_unhandled_input(false)

	if owner.object_to_interact is Collectable:
		print_debug("%s can be COLLECTED" % owner.object_to_interact.get_name())
		owner.object_to_interact.start_collect()
		Events.dialogue_question_answered.connect(_on_Dialogue_question_answered)
		return
	
	if owner.object_to_interact is Combinable and owner.inventory.has_item_equipped():
		print_debug("Player can tried to COMBINED %s with %s" % [owner.object_to_interact.get_name(), InventoryManager.item_to_string(owner.inventory.item_equipped_id)])
		owner.object_to_interact.start_combine(owner.inventory.item_equipped_id)
		Events.dialogue_text_displayed.connect(_on_Dialogue_text_displayed)
		return

	print_debug("%s can be INTERACTED with" % owner.object_to_interact.get_name())
	Events.dialogue_text_displayed.connect(_on_Dialogue_text_displayed)
	owner.object_to_interact.start_interaction()


func exit() -> void:
	_state_machine.set_process_unhandled_input(true)
	if Events.dialogue_text_displayed.is_connected(_on_Dialogue_text_displayed):
		Events.dialogue_text_displayed.disconnect(_on_Dialogue_text_displayed)


func _on_Dialogue_question_answered(answer) -> void:
	Events.dialogue_question_answered.disconnect(_on_Dialogue_question_answered)
	owner.object_to_interact.stop_interaction()
	
	if answer:
		_state_machine.transition_to("Move/Idle/Take", { id = owner.object_to_interact.id})
		return
	_state_machine.transition_to("Move/Idle")


func _on_Dialogue_text_displayed() -> void:
	_state_machine.set_process_unhandled_input(true)
