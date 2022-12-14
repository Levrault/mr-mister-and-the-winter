extends Control

signal inventory_item_equipped(id)

const SHOW_UI_TIME := 1.5

var InventoryItem = preload("res://src/player/hud/InventoryItem.tscn")

var items := []
var item_to_take_id: int = -1
var item_equipped_id: int = -1
var hidden_position := Vector2.ZERO
var show_position := Vector2.ZERO

@onready var hbox_container := $PanelContainer/HBoxContainer


func _ready() -> void:
	await owner.ready
	
	hidden_position = Vector2(position.x, position.y + custom_minimum_size.y)
	show_position = position
	
	for item in owner.pivot.get_node("Model/HandRight").get_children():
		items.append(item)
	for item in InventoryManager.items:
		add_item(item, false)
	hide()
	Events.inventory_focus_removed.connect(
		func():
			for item in hbox_container.get_children():
				item.release_focus()
	)


func is_physical_item(id: InventoryManager.Item) -> bool:
	if id == InventoryManager.Item.HAT:
		return false
	for item in items:
		if item.id == id:
			return true
	return false


func show_item(id: InventoryManager.Item) -> void:
	for item in items:
		if item.id == id:
			item.show()
			InventoryManager.add_item(id)
			add_item(id)
			continue
		item.hide()


func hide_item() -> void:
	for item in items:
		item.hide()


func show_item_to_take() -> void:
	show_item(item_to_take_id)


func show_equipped_item() -> void:
	for item in items:
		if item.id == item_equipped_id:
			item.show()
			continue
		item.hide()


func add_item(id: InventoryManager.Item, display_ui := true) -> void:
	print_debug("%s has been added to inventory" % InventoryManager.Item.find_key(id))
	if not is_physical_item(id):
		return
	
	print_debug("Inventory ui is displayed")
	var inventory_item := InventoryItem.instantiate()
	hbox_container.add_child(inventory_item)
	inventory_item.set_id(id)
	inventory_item.pressed.connect(_on_Inventory_item_pressed.bind(id))
	inventory_item.focus_entered.connect(
		func():
			$ClickAudioStreamPlayer.play()
	)

	if not display_ui:
		return
	
	show()
	var tween_control = create_tween().set_trans(Tween.TRANS_SINE)
	tween_control.tween_property(self, "position", show_position, .25)
	tween_control.tween_interval(SHOW_UI_TIME)
	tween_control.tween_property(self, "position", hidden_position, .25)
	tween_control.tween_callback(
		func():
			hide()
	)


func remove_item(id: InventoryManager.Item) -> void:
	hide_item()
	items.erase(id)
	item_equipped_id = -1
	for item in hbox_container.get_children():
		if item.id == id:
			item.queue_free()
			return


func show_ui() -> void:
	if visible:
		return
	print_debug("Player SHOW his inventory")
	show()
	var tween_control = create_tween().set_trans(Tween.TRANS_SINE)
	tween_control.tween_property(self, "position", show_position, .25)
	
	if hbox_container.get_child_count() > 0:
		if item_equipped_id != InventoryManager.Item.UNASSIGNED:
			for item in hbox_container.get_children():
				if item.id == item_equipped_id:
					item.grab_focus()
		else:
			hbox_container.get_child(0).grab_focus()


func hide_ui() -> void:
	if not visible:
		return
	print_debug("Player HIDE his inventory")
	var tween_control = create_tween().set_trans(Tween.TRANS_SINE)
	tween_control.tween_property(self, "position", hidden_position, .25)
	tween_control.tween_callback(
		func():
			hide()
	)

func has_item_equipped() -> bool:
	return item_equipped_id != -1 and item_equipped_id != InventoryManager.Item.UNASSIGNED


func _on_Inventory_item_pressed(id: InventoryManager.Item) -> void:
	print_debug("Player has choose %s from his inventory" % InventoryManager.item_to_string(id))
	
	if item_equipped_id == id:
		inventory_item_equipped.emit(InventoryManager.Item.UNASSIGNED)
		item_equipped_id = InventoryManager.Item.UNASSIGNED
		hide_item()
		return
	
	inventory_item_equipped.emit(id)
	item_equipped_id = id
	show_equipped_item()
	
