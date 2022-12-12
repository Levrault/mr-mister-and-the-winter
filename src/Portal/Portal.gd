extends Interactable
class_name Portal

@export var next_map: SceneManager.Maps
@export var portal_id := ""
@export var exterior_door_mesh := false

var is_active := true

@onready var spawn := $Spawn
@onready var look_at := $LookAt


func start_interaction() -> void:
	if is_active:
		Events.map_changed_for.emit(SceneManager.get_map_path(next_map), portal_id, exterior_door_mesh)
		GameManager.current_map = next_map
		return
	Events.dialogue_interaction_started.emit(text)


func stop_interaction() -> void:
	Events.dialogue_finished.emit()
