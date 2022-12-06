extends Area3D


func _ready() -> void:
	body_entered.connect(_on_Body_entered)
	body_exited.connect(_on_Body_exited)


func _on_Body_entered(body: Node3D) -> void:
	print("can interact with %s" % body.get_name())
	owner.object_to_interact = body.owner
	owner.exclamation_point.show()


func _on_Body_exited(_body: Node3D) -> void:
	owner.object_to_interact = null
	owner.exclamation_point.hide()
