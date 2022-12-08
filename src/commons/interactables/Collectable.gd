extends Interactable
class_name Collectable

@export var id: InventoryManager.Item
@export var can_be_queue_free := true


func _ready() -> void:
	add_to_group("collectable")
	
	if not can_be_queue_free:
		return
	
	Events.inventory_item_added.connect(_on_Inventory_item_added)
	if InventoryManager.has_item(id):
		queue_free()


func start_collect() -> void:
	Events.dialogue_collectable_started.emit(text)


func show_text() -> void:
	Events.dialogue_collectable_started.emit(text)


func _on_Inventory_item_added(item_id: InventoryManager.Item) -> void:
	if item_id != id:
		return
	queue_free()
