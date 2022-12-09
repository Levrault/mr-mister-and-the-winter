extends Interactable

@export var next_map := ""
@export var portal_id := ""

var is_active := true

@onready var spawn := $Spawn
@onready var look_at := $LookAt


func start_interaction() -> void:
	if is_active:
		Events.map_changed_for.emit(next_map, portal_id)
		return
	Events.dialogue_interaction_started.emit(text)


func stop_interaction() -> void:
	Events.dialogue_finished.emit()
