extends Node3D


func _ready() -> void:
	set_process_unhandled_input(false)
	$Transition.hide()
	$Camera3D.current = false
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		Events.dialogue_finished.emit()
		return
