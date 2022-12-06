extends Area3D


func _ready() -> void:
	body_entered.connect(_on_Body_entered)
	body_exited.connect(_on_Body_exited)
	area_entered.connect(_on_Area_entered)
	area_exited.connect(_on_Area_exited)


func _on_Body_entered(body: Node3D) -> void:
	print("can interact with %s" % body.get_name())
	owner.object_to_interact = body.owner
	owner.exclamation_point.show()


func _on_Body_exited(_body: Node3D) -> void:
	owner.object_to_interact = null
	owner.exclamation_point.hide()


func _on_Area_entered(_area: Area3D) -> void:
	owner.exclamation_point.show()


func _on_Area_exited(_area: Area3D) -> void:
	owner.exclamation_point.hide()
