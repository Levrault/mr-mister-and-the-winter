extends Node

enum Quest {
	THERMOSTAT,
	TIRE_1,
	TIRE_2,
	TIRE_3,
	TIRE_4,
	UNASSIGNED
}

var player: Player = null
var flags_list := {}


func _ready() -> void:
	for key in Quest.keys():
		flags_list[key] = false


func spawn_player(portal_id: String) -> void:
	for portal in get_tree().get_nodes_in_group("portals"):
		if portal.get_name() == portal_id:
			player.global_position.x = portal.spawn.global_position.x
			player.global_position.z = portal.spawn.global_position.z
			player.pivot.look_at(portal.look_at.global_position)
			return


func is_quest_accomplished(id: Quest) -> bool:
	return flags_list[Quest.find_key(id)]


func quest_done(id: Quest) -> void:
	print_debug("%s quest has been accomplished" % Quest.find_key(id))
	flags_list[Quest.find_key(id)] = true
	Events.quest_accomplished.emit(id)

