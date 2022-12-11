extends Node3D


func _ready() -> void:
	if not GameManager.is_quest_accomplished(GameManager.Quest.BOOTS) and not GameManager.is_quest_accomplished(GameManager.Quest.HAT):
		%PortalToYard.is_active = false
		Events.quest_accomplished.connect(_on_Quest_accomplished)
		return

	if GameManager.is_quest_accomplished(GameManager.Quest.CAR_TIRES):
		%N64.interacted.connect(_on_N64_interacted)
		return


func _on_Quest_accomplished(_id: GameManager.Quest) -> void:
	if GameManager.is_quest_accomplished(GameManager.Quest.BOOTS) and GameManager.is_quest_accomplished(GameManager.Quest.HAT):
		%PortalToYard.is_active = true
		Events.quest_accomplished.disconnect(_on_Quest_accomplished)


func _on_N64_interacted() -> void:
	%Player.set_active(false)
	$Cinematic.show()
	$Cinematic/AnimationPlayer.play("start")
