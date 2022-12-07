extends TextureButton

var id: int = -1

var CupTexture = preload("res://assets/textures/inventory/cup.png")
var TireTexture = preload("res://assets/textures/inventory/tire.png")
var ShovelTexture = preload("res://assets/textures/inventory/shovel.png")


func set_id(item_id: InventoryManager.Item) -> void:
	id = item_id

	match id:
		InventoryManager.Item.CUP:
			texture_normal = CupTexture
		InventoryManager.Item.SHOVEL:
			texture_normal = ShovelTexture
		InventoryManager.Item.TIRE_1:
			texture_normal = TireTexture
		InventoryManager.Item.TIRE_2:
			texture_normal = TireTexture
		InventoryManager.Item.TIRE_3:
			texture_normal = TireTexture
		InventoryManager.Item.TIRE_4:
			texture_normal = TireTexture
		_:
			texture_normal = TireTexture
