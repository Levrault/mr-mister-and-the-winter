extends Node
class_name Interactable

@export_multiline var text := "undefined"


func _ready() -> void:
	add_to_group("interactable")


func start_interaction() -> void:
	Events.start_dialog.emit(text)


func stop_interaction() -> void:
	Events.stop_dialog.emit()


func show_text() -> void:
	Events.start_dialog.emit(text)
