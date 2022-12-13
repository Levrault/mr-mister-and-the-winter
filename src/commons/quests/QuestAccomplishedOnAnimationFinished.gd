extends Node

@export_multiline var text := "Quest trigger text to be defined"
@export var quest: GameManager.Quest = GameManager.Quest.UNASSIGNED

var original_text_dialogue = ""


func _ready() -> void:
	await owner.ready
	if GameManager.is_quest_accomplished(quest):
		queue_free()
		return
	original_text_dialogue = owner.text
	owner.text = text
	owner.animation_player.animation_finished.connect(_on_Animation_finished)


func _on_Animation_finished(anim_name: String) -> void:
	if anim_name != "open":
		if Events.dialogue_text_displayed.is_connected(get_parent().get_node("SuccessFeedback").play):
			Events.dialogue_text_displayed.disconnect(get_parent().get_node("SuccessFeedback").play)
			queue_free()
		return
	GameManager.quest_done(quest)
	owner.text = original_text_dialogue
	
	if get_parent().has_node("SuccessFeedback"):
		Events.dialogue_text_displayed.connect(get_parent().get_node("SuccessFeedback").play)
