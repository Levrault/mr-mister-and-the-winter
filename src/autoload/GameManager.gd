extends Node

var player: Player = null


func spawn_player(portal_id: String) -> void:
	for portal in get_tree().get_nodes_in_group("portals"):
		if portal.get_name() == portal_id:
			player.global_position.x = portal.spawn.global_position.x
			player.global_position.z = portal.spawn.global_position.z
			player.pivot.look_at(portal.look_at.global_position)
			return
