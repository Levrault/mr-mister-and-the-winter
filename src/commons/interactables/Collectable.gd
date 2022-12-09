extends Interactable
class_name Collectable

@export var quest: GameManager.Quest = GameManager.Quest.UNASSIGNED
@export var id: InventoryManager.Item


func _ready() -> void:
	if owner is Player:
		return
	
	if InventoryManager.has_item(id) or GameManager.is_quest_accomplished(quest):
		queue_free()
		return
	
	add_to_group("collectable")
	Events.inventory_item_added.connect(_on_Inventory_item_added)


func start_collect() -> void:
	Events.dialogue_collectable_started.emit(text)


func show_text() -> void:
	Events.dialogue_collectable_started.emit(text)


func _on_Inventory_item_added(item_id: InventoryManager.Item) -> void:
	if item_id != id:
		return
	queue_free()
