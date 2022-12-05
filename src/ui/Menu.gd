extends Control

func _ready() -> void:
	%Resume.pressed.connect(_on_Resume_pressed)
	%RetroEffect.toggled.connect(_on_Retro_effect_pressed)
	%Quit.pressed.connect(
		func():
			get_tree().quit()
	)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		if (visible):
			hide()
			get_tree().paused = false
			return
		show()
		get_tree().paused = true
		%Resume.grab_focus()


func _on_Resume_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_Retro_effect_pressed(button_pressed: bool) -> void:
	
	if (button_pressed):
		%RetroEffect.text = "RETRO EFFECT - ON"
	else:
		%RetroEffect.text = "RETRO EFFECT - OFF"
	
	Events.retro_filter_changed.emit(button_pressed)
