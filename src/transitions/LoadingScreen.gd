extends Node3D


func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_Animation_finished)


func show() -> void:
	super()
	$Camera3D.current = true
	$AnimationPlayer.play("open")


func _on_Animation_finished(anim_name: String) -> void:
	hide()
	Events.loading_screen_animation_finished.emit()