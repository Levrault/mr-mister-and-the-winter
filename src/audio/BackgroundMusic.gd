extends AudioStreamPlayer


func _ready():
	Events.background_music_started.connect(
		func(): 
			volume_db = -40
			playing = true
			var tween = create_tween()
			tween.tween_property(self, "volume_db", 0, .5)
	)
	Events.background_music_stopped.connect(
		func():
			var tween = create_tween()
			tween.tween_property(self, "volume_db", -40, .5)
			playing = false
	)
