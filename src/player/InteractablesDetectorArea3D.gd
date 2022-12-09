extends Area3D


func _ready() -> void:
	body_entered.connect(_on_Body_entered)
	body_exited.connect(_on_Body_exited)
	area_entered.connect(_on_Area_entered)
	area_exited.connect(_on_Area_exited)


func _on_Body_entered(body: Node3D) -> void:
	print_debug("Player can interact with %s" % body.owner.get_name())
	owner.object_to_interact = body.owner
	
	if owner.inventory.has_item_equipped():
		owner.combine_indicator.show()
		return
	owner.interaction_indicator.show()


func _on_Body_exited(_body: Node3D) -> void:
	owner.object_to_interact = null
	owner.interaction_indicator.hide()
	owner.combine_indicator.hide()


# Used for portals
func _on_Area_entered(area: Area3D) -> void:
	owner.interaction_indicator.show()
	owner.object_to_interact = area.owner


func _on_Area_exited(_area: Area3D) -> void:
	owner.interaction_indicator.hide()
	owner.object_to_interact = null
