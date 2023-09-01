extends CanvasLayer

signal back_pressed

@onready var sfx_slider = %SfxSlider
@onready var music_slider = %MusicSlider
@onready var window_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/WindowOptionContainer/WindowButton

func _ready():
	%BackButton.pressed.connect(on_back_pressed)
	sfx_slider.value_changed.connect(on_audio_slider_changed.bind("sfx"))
	music_slider.value_changed.connect(on_audio_slider_changed.bind("music"))
	update_display()


func _on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	update_display()
	

func update_display():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "windowed"
	else:
		window_button.text = "fullscreen"
	sfx_slider.value = get_bus_volume_percent("sfx")
	music_slider.value = get_bus_volume_percent("music")
	

func get_bus_volume_percent(bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)

func set_bus_volume_percent(bus_name: String, percent: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index, volume_db)


func on_audio_slider_changed(value: float, bus_name: String):
	set_bus_volume_percent(bus_name, value)

func on_back_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	back_pressed.emit()
