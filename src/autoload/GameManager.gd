extends Node

enum Quest {
	THERMOSTAT,
	BOOTS,
	HAT,
	TIRES,
	CAR_TIRES,
	UNASSIGNED
}

enum Cinematic {
	INTRODUCTION_CINEMATIC,
	CAR_CINEMATIC,
	END_CREDITS
}

var player: Player = null
var flags_list := {}
var current_map: SceneManager.Maps = SceneManager.Maps.BEDROOM


func _ready() -> void:
	for key in Quest.keys():
		flags_list[key] = false
	for key in Cinematic.keys():
		flags_list[key] = false
#	# fake flag to remove
	flags_list[Cinematic.find_key(Cinematic.INTRODUCTION_CINEMATIC)] = true
#	flags_list[Quest.find_key(Quest.THERMOSTAT)] = true
#	flags_list[Quest.find_key(Quest.BOOTS)] = true
#	flags_list[Quest.find_key(Quest.HAT)] = true
#	flags_list[Quest.find_key(Quest.TIRES)] = true
#	flags_list[Quest.find_key(Quest.CAR_TIRES)] = true
#	flags_list[Cinematic.find_key(Cinematic.CAR_CINEMATIC)] = true


func spawn_player(portal_id: String) -> void:
	for portal in get_tree().get_nodes_in_group("portals"):
		if portal.get_name() == portal_id:
			player.global_position.x = portal.spawn.global_position.x
			player.global_position.z = portal.spawn.global_position.z
			player.pivot.look_at(portal.look_at.global_position)
			return


func is_quest_accomplished(id: Quest) -> bool:
	return flags_list[Quest.find_key(id)]


func is_cinematic_accomplished(id: Cinematic) -> bool:
	return flags_list[Cinematic.find_key(id)]


func quest_done(id: Quest) -> void:
	if id == Quest.UNASSIGNED:
		return
	print_debug("%s quest has been accomplished" % Quest.find_key(id))
	flags_list[Quest.find_key(id)] = true
	Events.quest_accomplished.emit(id)


func cinematic_done(id: Cinematic) -> void:
	print_debug("%s cinematic is overd" % Cinematic.find_key(id))
	flags_list[Cinematic.find_key(id)] = true
