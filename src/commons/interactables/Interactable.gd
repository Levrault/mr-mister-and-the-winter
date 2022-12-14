extends Node
class_name Interactable

signal interacted

@export_multiline var text := "undefined"

var text_default := text


func _ready() -> void:
	add_to_group("interactable")


func start_interaction() -> void:
	Events.dialogue_interaction_started.emit(text)


func stop_interaction() -> void:
	Events.dialogue_finished.emit()
	interacted.emit()
	
	# I have no shame for this hack
	if text_default != "undefined":
		text = text_default


func show_text() -> void:
	Events.dialogue_interaction_started.emit(text)
