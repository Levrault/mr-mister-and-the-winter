# meta-name: State
# meta-description: State of a State Machine
extends State


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		$AudioStreamPlayer.play()
		owner.animation_player.play_backwards("check_inventory")
		owner.animation_player.animation_finished.connect(_on_Animation_finished)
		return


func physics_process(_delta: float) -> void:
	return


func enter(_msg: Dictionary = {}) -> void:
	$AudioStreamPlayer.play()
	owner.animation_player.play("check_inventory")
	owner.inventory.show_ui()
	owner.inventory.inventory_item_equipped.connect(_on_Inventory_item_equipped)


func exit() -> void:
	owner.inventory.hide_ui()
	owner.inventory.inventory_item_equipped.disconnect(_on_Inventory_item_equipped)


func _on_Animation_finished(_anim_name: String) -> void:
	owner.animation_player.animation_finished.disconnect(_on_Animation_finished)
	_state_machine.transition_to("Move/Idle")


func _on_Inventory_item_equipped(_id: InventoryManager.Item):
	owner.animation_player.play_backwards("check_inventory")
	Events.inventory_focus_removed.emit()
	owner.animation_player.animation_finished.connect(_on_Animation_finished)
	if owner.object_to_interact != null:
		owner.combine_indicator.show()
		owner.interaction_indicator.hide()
