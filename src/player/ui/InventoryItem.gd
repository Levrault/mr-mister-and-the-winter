extends TextureButton

var id: int = -1

var CupTexture = preload("res://assets/textures/inventory/cup.png")
var CupTextureFocused = preload("res://assets/textures/inventory/cup_focused.png")
var ThermostatButtonTexture = preload("res://assets/textures/inventory/thermostat-button.png")
var ThermostatButtonTextureFocused = preload("res://assets/textures/inventory/thermostat-button_focused.png")
var TireTexture = preload("res://assets/textures/inventory/tire.png")
var TireTextureFocused = preload("res://assets/textures/inventory/tire_focused.png")
var ShovelTexture = preload("res://assets/textures/inventory/shovel.png")


func set_id(item_id: InventoryManager.Item) -> void:
	id = item_id

	match id:
		InventoryManager.Item.CUP:
			texture_normal = CupTexture
			texture_focused = CupTextureFocused
		InventoryManager.Item.THERMOSTAT_BUTTON:
			texture_normal = ThermostatButtonTexture
			texture_focused = ThermostatButtonTextureFocused
		InventoryManager.Item.SHOVEL:
			texture_normal = ShovelTexture
		InventoryManager.Item.TIRE_1:
			texture_normal = TireTexture
			texture_focused = TireTextureFocused
		InventoryManager.Item.TIRE_2:
			texture_normal = TireTexture
			texture_focused = TireTextureFocused
		InventoryManager.Item.TIRE_3:
			texture_normal = TireTexture
			texture_focused = TireTextureFocused
		InventoryManager.Item.TIRE_4:
			texture_normal = TireTexture
			texture_focused = TireTextureFocused

