extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventKey:
		get_parent().get_node("ScenesManager").init()
		queue_free()
		owner.call_deferred("emit_signal", "pause_menu_activated")
