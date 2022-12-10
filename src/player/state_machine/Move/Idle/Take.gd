# meta-name: State
# meta-description: State of a State Machine
extends State


func unhandled_input(_event: InputEvent) -> void:
	return


func physics_process(_delta: float) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	owner.animation_player.animation_finished.connect(_on_Animation_finished)
	owner.animation_player.play("take")
	
	if "id" in msg:
		owner.inventory.item_to_take_id = msg.id


func exit() -> void:
	owner.animation_player.animation_finished.disconnect(_on_Animation_finished)


func _on_Animation_finished(anim_name: String) -> void:
	assert(anim_name == "take")
	_state_machine.transition_to("Move/Idle")
