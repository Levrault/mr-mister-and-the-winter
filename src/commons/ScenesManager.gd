extends Node
class_name SceneManager

enum Maps {
	BEDROOM,
	KITCHEN_LIVING_ROOM,
	YARD
}
enum LoadingType {
	Portal,
	Transition
}

const BEDROOM_MAP_PATH := "res://src/maps/Bedroom.tscn"
const KITCHEN_LIVING_ROOM_MAP_PATH := "res://src/maps/KitchenAndLivingRoom.tscn"
const YARD_PATH := "res://src/maps/Yard.tscn"

@export var map = Maps.BEDROOM:
	set(value):
		map = value
		GameManager.current_map = value
	get:
		return map

var LoadingScreenPortal := preload("res://src/loading_screens/LoadingScreenPortal.tscn")
var LoadingScreenText := preload("res://src/loading_screens/LoadingScreenText.tscn")
var current_scene: Node3D = null
var status := 0
var scene_path := ""
var can_add_resource_on_process := false
var last_portal_id := ""
var loading_screen = null


static func get_map_path(id: Maps) -> String:
	match id:
		Maps.BEDROOM:
			return BEDROOM_MAP_PATH
		Maps.KITCHEN_LIVING_ROOM:
			return KITCHEN_LIVING_ROOM_MAP_PATH
		Maps.YARD:
			return YARD_PATH
	printerr("the path doesn't map any Map enum")
	return ""


func _ready() -> void:
	Events.map_changed_for.connect(_on_Map_changed_for)
	
	load_maps(SceneManager.get_map_path(map))


func _process(_delta: float):
	status = ResourceLoader.load_threaded_get_status(scene_path)
	if status == ResourceLoader.THREAD_LOAD_LOADED and can_add_resource_on_process:
		var resource := ResourceLoader.load_threaded_get(scene_path)
		current_scene = resource.instantiate()
		add_child(current_scene)
		can_add_resource_on_process = false
		loading_screen.queue_free()
		set_process(false)


func load_maps(path: String) -> void:
	set_process(true)
	scene_path = path
	ResourceLoader.load_threaded_request(scene_path)
	
	if get_child_count() > 0:
		get_child(0).queue_free() 
	Events.loading_screen_animation_finished.connect(_on_Loading_screen_animation_finished)

	# transition
	loading_screen = LoadingScreenText.instantiate()
	add_child(loading_screen)
	loading_screen.show()


func _on_Map_changed_for(path: String, portal_id: String, is_door_exterior := false) -> void:
	set_process(true)
	scene_path = path
	last_portal_id = portal_id
	ResourceLoader.load_threaded_request(scene_path)
	
	if get_child_count() > 0:
		get_child(0).queue_free() 
	Events.loading_screen_animation_finished.connect(_on_Loading_screen_animation_finished)

	# transition
	loading_screen = LoadingScreenPortal.instantiate()
	if is_door_exterior:
		loading_screen.use_exterior_door_model()
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
