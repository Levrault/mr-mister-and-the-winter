extends Control


func _ready():
	Events.loading_screen_animation_finished.emit()
