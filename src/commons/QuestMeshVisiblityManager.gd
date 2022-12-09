extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.is_quest_accomplished(owner.quest):
		show()
		return
	hide()
	Events.quest_accomplished.connect(_on_Quest_accomplished)


func _on_Quest_accomplished(id: GameManager.Quest) -> void:
	if id != owner.quest:
		return
	show()
	Events.quest_accomplished.disconnect(_on_Quest_accomplished)
