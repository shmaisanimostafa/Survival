extends CanvasLayer

var options_scene = preload("res://scenes/ui/options_menu.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_options_button_pressed():
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))

func _on_quit_button_pressed():
	get_tree().quit()

func on_options_closed(options_instance: Node):
	options_instance.queue_free()
