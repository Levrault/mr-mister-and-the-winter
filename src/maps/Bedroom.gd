extends Node3D

@export_multiline var radio_text := "GOOODDDD MORNING! Beware there is big storm coming out! I hope you all have installer your winter tires!"


func _ready() -> void:
	if not GameManager.is_quest_accomplished(GameManager.Quest.THERMOSTAT):
		%PortalToKitchen.is_active = false
		Events.quest_accomplished.connect(_on_Quest_accomplished)
	
	if not GameManager.is_cinematic_accomplished(GameManager.Cinematic.INTRODUCTION_CINEMATIC):
		$IntroductionCinematic/AnimationPlayer.play("introduction")
		$Player.hide()
		$Player.set_active(false)
		return


func cinematic_finished(id: GameManager.Cinematic) -> void:
	GameManager.cinematic_done(id)
	Events.dialogue_text_displayed.disconnect($IntroductionCinematic.set_process_unhandled_input)
	Events.dialogue_finished.disconnect($IntroductionCinematic/AnimationPlayer.play)
	$Player.set_active(true)
	$IntroductionCinematic.queue_free()
	


func show_radio_text() -> void:
	Events.dialogue_interaction_started.emit(radio_text)
	Events.dialogue_text_displayed.connect($IntroductionCinematic.set_process_unhandled_input.bind(true))
	Events.dialogue_finished.connect($IntroductionCinematic/AnimationPlayer.play.bind("finished"))


func _on_Quest_accomplished(id: GameManager.Quest) -> void:
	if id == GameManager.Quest.THERMOSTAT:
		%PortalToKitchen.is_active = true
		Events.quest_accomplished.disconnect(_on_Quest_accomplished)

