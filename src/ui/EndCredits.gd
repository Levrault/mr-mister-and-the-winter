extends Control


func _ready() -> void:
	Events.end_credit_displayed.connect(_on_End_credit_displayed)
	set_process_unhandled_input(false)
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventKey:
		get_tree().quit()


func _on_End_credit_displayed() -> void:
	show()
	var tween_credit = create_tween()
	tween_credit.tween_property($Credits, "position:y", -$Credits.size.y, 10)
	tween_credit.tween_callback(
		func():
			var tween_author = create_tween()
			tween_author.tween_property($Author, "modulate:a", 1, 3)
			tween_author.tween_callback(
				func():
					set_process_unhandled_input(true)
			)
	)
