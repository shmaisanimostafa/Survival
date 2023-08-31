extends CanvasLayer


@onready var panel = %Panel


func _ready():
	panel.pivot_offset = panel.size / 2
	var tween = create_tween()
	tween.tween_property(panel, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	get_tree().paused = true


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func set_defeat():
	$%TitleLabel.text = "defeat"
	$%DescriptionLabel.text = "You Lost!"
