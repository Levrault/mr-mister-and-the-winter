extends Node3D


@export_multiline var radio_text := "GOOODDDD MORNING! Since the storm is too strong, everything is close! Enjoy a free day to play video game!"


func _ready() -> void:
	if not GameManager.is_cinematic_accomplished(GameManager.Cinematic.CAR_CINEMATIC):
		Events.quest_accomplished.connect(_on_Quest_accomplished)
		return


func cinematic_finished() -> void:
	GameManager.cinematic_done(GameManager.Cinematic.CAR_CINEMATIC)
	Events.dialogue_text_displayed.disconnect($Cinematic.set_process_unhandled_input)
	Events.dialogue_finished.disconnect($Cinematic/AnimationPlayer.play)
	%Player.show()
	%Player.set_active(true)
	%Player.state_machine.transition_to("Move/Idle")
  

func show_radio_text() -> void:
	Events.dialogue_interaction_started.emit(radio_text)
	Events.dialogue_text_displayed.connect($Cinematic.set_process_unhandled_input.bind(true))
	Events.dialogue_finished.connect($Cinematic/AnimationPlayer.play.bind("finished"))


func _on_Quest_accomplished(id: GameManager.Quest) -> void:
	if id != GameManager.Quest.CAR_TIRES:
		return
	$Player.hide()
	%Player.set_active(false)
	$Cinematic/AnimationPlayer.play("start")

