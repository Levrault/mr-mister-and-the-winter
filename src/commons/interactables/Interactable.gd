extends Node
class_name Interactable

@export_multiline var text := "undefined"


func start_interaction() -> void:
	return


func stop_interaction() -> void:
	return


func show_text() -> void:
	Events.start_dialog.emit(text)
