extends Node

func die_respawn() -> void:
	await get_tree().process_frame
	
	var player = get_tree().get_first_node_in_group("Player")
	var spawn = get_tree().get_first_node_in_group("SpawnPoint")
	if player:	
		if spawn:
			player.global_position = spawn.global_position
		
		player.hp = player.max_hp
		player.ForBars.update_health(player.hp)
		player.reset_bounce_energy()
