extends Node
class_name Interactable

@export_multiline var text := "undefined"

var is_collectable := false


func _ready() -> void:
	add_to_group("interactable")


func start_interaction() -> void:
	Events.dialogue_started.emit(text, is_collectable)


func stop_interaction() -> void:
	Events.dialogue_finished.emit()


func show_text() -> void:
	Events.dialogue_started.emit(text, is_collectable)
