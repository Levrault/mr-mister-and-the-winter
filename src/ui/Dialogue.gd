extends Control

var has_question := false

func _ready() -> void:
	Events.dialogue_started.connect(_on_Dialogue_started)
	Events.dialogue_finished.connect(_on_Dialogue_finished)
	$QuestionContainer/Yes.pressed.connect(_on_Yes_pressed)
	$QuestionContainer/No.pressed.connect(_on_No_pressed)
	hide()


func _on_Dialogue_started(text: String, is_collectable := false) -> void:
	%RichTextLabel.text = text
	%RichTextLabel.visible_ratio = 0
	$PanelContainer.scale = Vector2.ZERO
	%QuestionContainer.hide()
	
	show()
	
	var tween_panel = create_tween()
	tween_panel.tween_property($PanelContainer, "scale", Vector2(1,1), .5)
	tween_panel.tween_callback(
		func():
			var tween_rich_text = create_tween()
			tween_rich_text.tween_property(%RichTextLabel, "visible_ratio", 1, .5)
			if not is_collectable:
				return
			tween_rich_text.tween_callback(
				func():
						%QuestionContainer.show()
						%QuestionContainer.get_node("Yes").grab_focus()
			)
	)


func _on_Dialogue_finished() -> void:
	hide()
	%RichTextLabel.text = ""
	%RichTextLabel.visible_ratio = 0
	$PanelContainer.scale = Vector2.ZERO


func _on_Yes_pressed() -> void:
	_on_Dialogue_finished()
	Events.dialogue_question_answered.emit(true)
	print("_on_Yes_pressed")


func _on_No_pressed() -> void:
	print("_on_No_pressed")
	_on_Dialogue_finished()
	Events.dialogue_question_answered.emit(false)
