extends Control

var has_question := false

func _ready() -> void:
	Events.dialogue_interaction_started.connect(_on_Dialogue_interaction_started)
	Events.dialogue_collectable_started.connect(_on_Dialogue_collectable_started)
	Events.dialogue_combinable_started.connect(_on_Dialogue_combinable_started)
	Events.dialogue_finished.connect(_on_Dialogue_finished)
	$QuestionContainer/Yes.pressed.connect(
		func():
			_on_Dialogue_finished()
			Events.dialogue_question_answered.emit(true)
			$ConfirmationAudioStreamPlayer.play()
	)
	$QuestionContainer/Yes.focus_entered.connect(
		func():
			$SelectAudioStreamPlayer.play()
	)
	$QuestionContainer/No.pressed.connect(
		func():
			_on_Dialogue_finished()
			Events.dialogue_question_answered.emit(false)
			$ErrorAudioStreamPlayer.play()
	)
	$QuestionContainer/No.focus_entered.connect(
		func():
			$SelectAudioStreamPlayer.play()
	)

	$InteractIcon.hide()
	hide()


func reset_dialogue_before_animation(text: String) -> void:
	%RichTextLabel.text = text
	%RichTextLabel.visible_ratio = 0
	$PanelContainer.scale = Vector2.ZERO
	%QuestionContainer.hide()
	$InteractIcon.hide()
	$AnimationPlayer.stop()
	show()


func enable_interact_icone() -> void:
	$InteractIcon.show()
	$AnimationPlayer.play("interact")


func _on_Dialogue_interaction_started(text: String) -> void:
	reset_dialogue_before_animation(text)
	
	var tween_panel = create_tween()
	tween_panel.tween_property($PanelContainer, "scale", Vector2(1,1), .5)
	tween_panel.tween_callback(
		func():
			var tween_rich_text = create_tween()
			tween_rich_text.tween_property(%RichTextLabel, "visible_ratio", 1, .5)
			tween_rich_text.tween_callback(
				func():
					$ClickAudioStreamPlayer.play()
					Events.dialogue_text_displayed.emit()
					enable_interact_icone()
			)

	)


func _on_Dialogue_collectable_started(text: String) -> void:
	reset_dialogue_before_animation(text)
	
	var tween_panel = create_tween()
	tween_panel.tween_property($PanelContainer, "scale", Vector2(1,1), .5)
	tween_panel.tween_callback(
		func():
			var tween_rich_text = create_tween()
			tween_rich_text.tween_property(%RichTextLabel, "visible_ratio", 1, .5)
			tween_rich_text.tween_callback(
				func():
					%QuestionContainer.show()
					%QuestionContainer.get_node("Yes").grab_focus()
			)
	)


func _on_Dialogue_combinable_started(text: String) -> void:
	reset_dialogue_before_animation(text)
	
	var tween_panel = create_tween()
	tween_panel.tween_property($PanelContainer, "scale", Vector2(1,1), .5)
	tween_panel.tween_callback(
		func():
			var tween_rich_text = create_tween()
			tween_rich_text.tween_property(%RichTextLabel, "visible_ratio", 1, .5)
			tween_rich_text.tween_callback(
				func():
					Events.dialogue_text_displayed.emit()
					enable_interact_icone()
			)
	)


func _on_Dialogue_finished() -> void:
	hide()
	%RichTextLabel.text = ""
	%RichTextLabel.visible_ratio = 0
	$PanelContainer.scale = Vector2.ZERO
