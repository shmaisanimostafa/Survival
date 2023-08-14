extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_area_2d_area_entered(_area):
	GameEvents.emit_experience_vial_collected(1)
	queue_free()
