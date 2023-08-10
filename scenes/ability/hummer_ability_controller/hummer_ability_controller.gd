extends Node

const MAX_RANGE = 150
@export var hummer_ability : PackedScene 


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	if enemies.size() == 0:
		return 
		
	enemies.sort_custom(func(A: Node2D, B : Node2D) :
		var a_distance = A.global_position.distance_squared_to(player.global_position)
		var b_distance = B.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
		
	var hummer_instance = hummer_ability.instantiate() as Node2D
	player.get_parent().add_child(hummer_instance)
	hummer_instance.global_position = enemies[0].global_position
	hummer_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

	var enemy_direction = enemies[0].global_position - hummer_instance.global_position
	hummer_instance.rotation = enemy_direction.angle()
