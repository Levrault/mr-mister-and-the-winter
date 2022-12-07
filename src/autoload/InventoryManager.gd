extends Node

enum Item {
	CUP,
	TIRE_1,
	TIRE_2,
	TIRE_3,
	TIRE_4,
	SHOVEL
}

var items := []


func _ready() -> void:
	# to remove
	items.append(Item.CUP)
	items.append(Item.TIRE_1)
	items.append(Item.TIRE_2)
	items.append(Item.SHOVEL)


func add_item(id: Item) -> void:
	items.append(id)
	Events.inventory_item_added.emit(id)


func has_item(id: Item) -> bool:
	return items.has(id)
