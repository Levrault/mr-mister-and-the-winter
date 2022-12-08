extends Interactable
class_name Combinable

@export var item_id_to_combine_with: InventoryManager.Item
@export var destroy_item_on_success := true

@export_category("Text")
@export_multiline var combine_success_text := "undefined"
@export_multiline var combine_failed_text := "undefined"

@onready var success_feedback := $CombineSuccessFeedback
@onready var failed_feedback := $CombineFailedFeedback


func start_combine(item_id: InventoryManager.Item) -> void:
	if item_id != item_id_to_combine_with:
		print_debug("combinaison FAILED between %s and %s" % [InventoryManager.item_to_string(item_id), InventoryManager.item_to_string(item_id_to_combine_with)])
		Events.dialogue_combinable_started.emit(combine_failed_text)
		Events.dialogue_text_displayed.connect(_on_Dialogue_text_displayed_failed)
		return
	
	print_debug("combinaison SUCCESS between %s and %s" % [InventoryManager.item_to_string(item_id), InventoryManager.item_to_string(item_id_to_combine_with)])
	Events.dialogue_combinable_started.emit(combine_success_text)
	Events.dialogue_text_displayed.connect(_on_Dialogue_text_displayed_success)


func _on_Dialogue_text_displayed_success() -> void:
	success_feedback.play()
	Events.dialogue_text_displayed.disconnect(_on_Dialogue_text_displayed_success)
	
	if destroy_item_on_success:
		InventoryManager.destroy_item(item_id_to_combine_with)


func _on_Dialogue_text_displayed_failed() -> void:
	failed_feedback.play()
	Events.dialogue_text_displayed.disconnect(_on_Dialogue_text_displayed_failed)
