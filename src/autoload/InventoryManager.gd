extends Node

enum Item {
	CUP,
	HAT,
	THERMOSTAT_BUTTON,
	TIRE_1,
	TIRE_2,
	TIRE_3,
	TIRE_4,
	SHOVEL,
	UNASSIGNED
}

var items := []
var destroyed_items := []


#func _ready() -> void:
#	add_item(Item.SHOVEL)


func add_item(id: Item) -> void:
	items.append(id)
	Events.inventory_item_added.emit(id)


func destroy_item(id: Item) -> void:
	destroyed_items.append(id)
	items.erase(id)
	GameManager.player.inventory.remove_item(id)


func has_item(id: Item) -> bool:
	return items.has(id)


func is_item_destroyed(id: Item) -> bool:
	return destroyed_items.has(id)


func item_to_string(id: Item) -> String:
	return Item.find_key(id)
