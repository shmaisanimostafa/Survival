extends Node

@export var victory_screen_scene: PackedScene
@onready var timer = $Timer


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func _on_timer_timeout():
	var victory_screen_instance = victory_screen_scene.instantiate()
	add_child(victory_screen_instance)
