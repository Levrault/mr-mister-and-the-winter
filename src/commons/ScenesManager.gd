extends Node

var LoadingScreen := preload("res://src/transitions/LoadingScreen.tscn")
var current_scene: Node3D = null
var status := 0
var scene_path := ""
var can_add_resource_on_process := false
var last_portal_id := ""
var loading_screen = null


func _ready():
	Events.map_changed_for.connect(_on_Map_changed_for)
	current_scene = get_child(0)
	set_process(false)


func _process(time):
	status = ResourceLoader.load_threaded_get_status(scene_path)
	if status == ResourceLoader.THREAD_LOAD_LOADED and can_add_resource_on_process:
		var resource := ResourceLoader.load_threaded_get(scene_path)
		current_scene = resource.instantiate()
		add_child(current_scene)
		can_add_resource_on_process = false
		set_process(false)


func _on_Map_changed_for(path: String, portal_id: String) -> void:
	set_process(true)
	scene_path = path
	last_portal_id = portal_id
	ResourceLoader.load_threaded_request(scene_path)
	current_scene.queue_free() 
	Events.loading_screen_animation_finished.connect(_on_Loading_screen_animation_finished)

	# transition
	loading_screen = LoadingScreen.instantiate()
	add_child(loading_screen)
	loading_screen.show()


func _on_Loading_screen_animation_finished() -> void:
	Events.loading_screen_animation_finished.disconnect(_on_Loading_screen_animation_finished)
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var resource = ResourceLoader.load_threaded_get(scene_path)
		current_scene = resource.instantiate()
		loading_screen.queue_free()
		add_child(current_scene)
		GameManager.spawn_player(last_portal_id)
		return
	can_add_resource_on_process = true
