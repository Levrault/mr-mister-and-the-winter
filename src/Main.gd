extends Node3D


func _ready() -> void:
	Events.retro_filter_changed.connect(_on_Retro_filter_changed)


func _on_Retro_filter_changed(value: bool) -> void:
	%HBlur.material.set_shader_parameter("enabled", value)
	%DitherBand.material.set_shader_parameter("enabled", value)
	%CrtTvEffect.visible = value
