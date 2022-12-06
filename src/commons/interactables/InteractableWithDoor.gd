extends Interactable

@onready var animation_player := $AnimationPlayer


func _ready() -> void:
	animation_player.animation_finished.connect(_on_Animation_finished)


func start_interaction() -> void:
	animation_player.play("open")


func stop_interaction():
	animation_player.play("close")


func _on_Animation_finished(anim_name: String) -> void:
	if anim_name != "open":
		return
	show_text()
