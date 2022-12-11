extends Camera3D


@export var max_z := 5.0
@export var min_z := -4.0


func _process(_delta: float) -> void:
	position.z = clamp(%Player.position.z, min_z, max_z)
