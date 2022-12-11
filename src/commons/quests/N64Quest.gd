extends Node3D

@export var quest: GameManager.Quest = GameManager.Quest.CAR_TIRES
@export_multiline var text := "Quest n64 done text"


func _ready() -> void:
	await owner.ready
	if GameManager.is_quest_accomplished(quest):
		owner.text = text
		return
	Events.quest_accomplished.connect(_on_Quest_accomplished)


func _on_Quest_accomplished(id: GameManager.Quest) -> void:
	if id != quest:
		return
	owner.text = text
