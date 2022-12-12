extends Node3D


func _ready() -> void:
	Events.inventory_item_added.connect(_on_Inventory_item_added)


func _on_Inventory_item_added(_item_id: InventoryManager.Item) -> void:
	if InventoryManager.has_item(InventoryManager.Item.TIRE_1) and InventoryManager.has_item(InventoryManager.Item.TIRE_2) and InventoryManager.has_item(InventoryManager.Item.TIRE_3) and InventoryManager.has_item(InventoryManager.Item.TIRE_4):
		GameManager.quest_done(GameManager.Quest.TIRES)
