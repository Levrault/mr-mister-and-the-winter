extends Node3D


func _ready() -> void:
	if not GameManager.is_quest_accomplished(GameManager.Quest.BOOTS) and not GameManager.is_quest_accomplished(GameManager.Quest.HAT):
		%PortalToYard.is_active = false
		Events.quest_accomplished.connect(_on_Quest_accomplished)


func _on_Quest_accomplished(id: GameManager.Quest) -> void:
	if GameManager.is_quest_accomplished(GameManager.Quest.BOOTS) and GameManager.is_quest_accomplished(GameManager.Quest.HAT):
		%PortalToYard.is_active = true
		Events.quest_accomplished.disconnect(_on_Quest_accomplished)
