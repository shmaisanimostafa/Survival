extends Node

const MAX_RANGE = 150

@export var hummer_ability : PackedScene 

var base_damage = 5
var additional_damage_percent = 1
var base_wait_time


func _ready():
	base_wait_time = $Timer.wait_time
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


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
		
	var hummer_instance = hummer_ability.instantiate() as HummerAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(hummer_instance)
	hummer_instance.hitbox_component.damage = base_damage * additional_damage_percent
	hummer_instance.global_position = enemies[0].global_position
	hummer_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

	var enemy_direction = enemies[0].global_position - hummer_instance.global_position
	hummer_instance.rotation = enemy_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "hummer_rate":
		var percent_reduction = current_upgrades["hummer_rate"]["quantity"] * .5
		$Timer.wait_time = base_wait_time * (1-percent_reduction)
		$Timer.start()
	elif upgrade.id == "hummer_damage":
		additional_damage_percent = 1+ (current_upgrades["hummer_damage"]["quantity"] * .15)
