extends Interactable
class_name Combinable

@export var quest: GameManager.Quest = GameManager.Quest.UNASSIGNED
@export var item_id_to_combine_with: InventoryManager.Item
@export var destroy_item_on_combine := false
@export var destroy_inventory_item_on_success := true
@export var can_be_combined_only_once := true

@export_category("Text")
@export_multiline var combine_success_text := "undefined"
@export_multiline var combine_failed_text := "undefined"
@export_multiline var combine_done := "undefined"

var combine_succeed := false

@onready var success_feedback := $CombineSuccessFeedback
@onready var failed_feedback := $CombineFailedFeedback


func start_interaction() -> void:
	if GameManager.is_quest_accomplished(quest):
		Events.dialogue_interaction_started.emit(combine_done)
		return
	super()


func stop_interaction() -> void:
	if destroy_item_on_combine and combine_succeed:
		queue_free()
		return
	super()


func start_combine(item_id: InventoryManager.Item) -> void:
	if GameManager.is_quest_accomplished(quest):
		Events.dialogue_interaction_started.emit(combine_done)
		return

	if item_id != item_id_to_combine_with:
		print_debug("combinaison FAILED between %s and %s" % [InventoryManager.item_to_string(item_id), InventoryManager.item_to_string(item_id_to_combine_with)])
		Events.dialogue_combinable_started.emit(combine_failed_text)
		Events.dialogue_text_displayed.connect(_on_Dialogue_text_displayed_failed)
		return
	
	print_debug("combinaison SUCCESS between %s and %s" % [InventoryManager.item_to_string(item_id), InventoryManager.item_to_string(item_id_to_combine_with)])
	combine_succeed = true
	Events.dialogue_combinable_started.emit(combine_success_text)
	Events.dialogue_text_displayed.connect(_on_Dialogue_text_displayed_success)


func _on_Dialogue_text_displayed_success() -> void:
	Events.dialogue_text_displayed.disconnect(_on_Dialogue_text_displayed_success)
	Events.combine_succeed.emit()
	success_feedback.play()
	
	if quest != GameManager.Quest.UNASSIGNED:
		GameManager.quest_done(quest)

	if destroy_inventory_item_on_success:
		print_debug("%s has destroyed %s in player inventory" % [get_name(), InventoryManager.item_to_string(item_id_to_combine_with)])
		InventoryManager.destroy_item(item_id_to_combine_with)


func _on_Dialogue_text_displayed_failed() -> void:
	failed_feedback.play()
	Events.dialogue_text_displayed.disconnect(_on_Dialogue_text_displayed_failed)
