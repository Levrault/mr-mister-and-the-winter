extends Control


func _ready() -> void:
	Events.start_dialog.connect(_on_Start_dialog)
	Events.stop_dialog.connect(_on_Stop_dialog)
	hide()
	

func _on_Start_dialog(text: String) -> void:
	%RichTextLabel.text = text
	%RichTextLabel.visible_ratio = 0
	$PanelContainer.scale = Vector2.ZERO
	
	show()
	
	var tween_panel = create_tween()
	tween_panel.tween_property($PanelContainer, "scale", Vector2(1,1), .5)
	tween_panel.tween_callback(
		func():
			var tween_rich_text = create_tween()
			tween_rich_text.tween_property(%RichTextLabel, "visible_ratio", 1, .5)
	)


func _on_Stop_dialog() -> void:
	hide()
	%RichTextLabel.text = ""
	%RichTextLabel.visible_ratio = 0
	$PanelContainer.scale = Vector2.ZERO
	
