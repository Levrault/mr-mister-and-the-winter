extends Node

@export_multiline var text := "Quest done text"


func _ready() -> void:
	await owner.ready
	if GameManager.is_quest_accomplished(owner.quest):
		owner.combine_done = text
		return
	Events.quest_accomplished.connect(_on_Quest_accomplished)


func _on_Quest_accomplished(id: GameManager.Quest) -> void:
	if id != owner.quest:
		return
	owner.combine_done = text
