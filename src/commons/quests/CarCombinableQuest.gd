extends Combinable

var last_item_combined: InventoryManager.Item = -1

var items_list_id_to_combine_with: Array[InventoryManager.Item] = []


func _ready() -> void:
	items_list_id_to_combine_with.append(InventoryManager.Item.TIRE_1)
	items_list_id_to_combine_with.append(InventoryManager.Item.TIRE_2)
	items_list_id_to_combine_with.append(InventoryManager.Item.TIRE_3)
	items_list_id_to_combine_with.append(InventoryManager.Item.TIRE_4)
	
	if GameManager.is_quest_accomplished(quest):
		$Tire1.show()
		$Tire2.show()
		$Tire3.show()
		$Tire4.show()
	else:
		$Tire1.hide()
		$Tire2.hide()
		$Tire3.hide()
		$Tire4.hide()


func start_combine(item_id: InventoryManager.Item) -> void:
	if GameManager.is_quest_accomplished(quest):
		Events.dialogue_interaction_started.emit(combine_done)
		return

	if not items_list_id_to_combine_with.has(item_id):
		print_debug("combinaison FAILED between %s and %s" % [InventoryManager.item_to_string(item_id), InventoryManager.item_to_string(item_id_to_combine_with)])
		Events.dialogue_combinable_started.emit(combine_failed_text)
		Events.dialogue_text_displayed.connect(_on_Dialogue_text_displayed_failed)
		return
	
	print_debug("MULTI combinaison SUCCESS")	
	last_item_combined = item_id
	items_list_id_to_combine_with.erase(item_id)
	
	if items_list_id_to_combine_with.is_empty():
		combine_succeed = true
	Events.dialogue_combinable_started.emit(combine_success_text)
	Events.dialogue_text_displayed.connect(_on_Dialogue_text_displayed_success)


func _on_Dialogue_text_displayed_success() -> void:
	Events.dialogue_text_displayed.disconnect(_on_Dialogue_text_displayed_success)
	success_feedback.play()
	
	if last_item_combined == InventoryManager.Item.TIRE_1:
		$Tire1.show()
	if last_item_combined == InventoryManager.Item.TIRE_2:
		$Tire2.show()
	if last_item_combined == InventoryManager.Item.TIRE_3:
		$Tire3.show()
	if last_item_combined == InventoryManager.Item.TIRE_4:
		$Tire4.show()
	
	if quest != GameManager.Quest.UNASSIGNED and items_list_id_to_combine_with.is_empty():
		Events.dialogue_finished.connect(_on_Dialogue_finished)

	if destroy_inventory_item_on_success:
		print_debug("%s has destroyed %s in player inventory" % [get_name(), InventoryManager.item_to_string(last_item_combined)])
		InventoryManager.destroy_item(last_item_combined)


func _on_Dialogue_finished() -> void:
	GameManager.quest_done(quest)
	Events.dialogue_finished.disconnect(_on_Dialogue_finished)
	
	
