extends Node

@export_multiline var text := "Quest trigger text to be defined"

var original_text_dialogue = ""

func _ready() -> void:
	await owner.ready
	if GameManager.is_quest_accomplished(owner.quest):
		queue_free()
		return
	original_text_dialogue = owner.text
	owner.text = text
	owner.animation_player.animation_finished.connect(_on_Animation_finished)


func _on_Animation_finished(anim_name: String) -> void:
	if anim_name != "open":
		return
	owner.animation_player.animation_finished.disconnect(_on_Animation_finished)
	owner.text = original_text_dialogue
