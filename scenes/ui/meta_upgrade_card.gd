extends PanelContainer

@onready var progress_bar = %ProgressBar
@onready var name_label: Label = %NameLabel
@onready var purchase_button = %PurchaseButton
@onready var description_label: Label = %DescriptionLabel
@onready var progress_label = %ProgressLabel


var upgrade : MetaUpgrade


func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()


func update_progress():
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent =  currency / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)


func select_card():
	$AnimationPlayer.play("selected")
	$AnimationPlayer.animation_finished


func _on_purchase_button_pressed():
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	$AnimationPlayer.play("selected")
