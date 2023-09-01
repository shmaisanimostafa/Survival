extends Node

var save_data: Dictionary = {
#	"win_count": 0,
#	"loss_count": 0,
	"meta_upgrade_currency": 0,
	"meta_upgrades": {
#		"experince_gain":{
#			"quantity": 1,
#			}
	}
}

var Save_File_Path = "user://game.save"


func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_collected)
	load_save_file()


func on_experience_collected(number: float):
	save_data["meta_upgrade_currency"] += number


func add_meta_upgrade(upgrade: MetaUpgrade):
	if not save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
		}
	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	save()


func load_save_file():
	if not FileAccess.file_exists(Save_File_Path):
		return
	var file = FileAccess.open(Save_File_Path, FileAccess.READ)
	save_data = file.get_var()
	

func save():
	var file = FileAccess.open(Save_File_Path, FileAccess.WRITE)
	file.store_var(save_data)

func get_upgrade_count(upgrade_id: String):
	if save_data["meta_upgrades"].has(upgrade_id):
		return save_data["meta_upgrades"][upgrade_id]["quantity"]
	return 0


