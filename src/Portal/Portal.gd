extends Node3D

@export var next_map := ""
@export var portal_id := ""
@onready var spawn := $Spawn
@onready var look_at := $LookAt


func _ready() -> void:
	$Area3D.body_entered.connect(_on_Body_entered)
	$Area3D.body_exited.connect(_on_Body_exited)
	set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("interact")):
		Events.map_changed_for.emit(next_map, portal_id)


func _on_Body_entered(body: Node3D) -> void:
	if not body is Player:
		return
	body.exclamation_point.show()
	set_process_unhandled_input(true)


func _on_Body_exited(body: Node3D) -> void:
	if not body is Player:
		return
	body.exclamation_point.hide()
	set_process_unhandled_input(false)
