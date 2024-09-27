extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "settings_menu/settings.ini"

func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybinding", "ui_left", "A")
		config.set_value("keybinding", "ui_up", "W")
		config.set_value("keybinding", "ui_down", "S")
		config.set_value("keybinding", "ui_right", "D")
		config.set_value("keybinding", "Interact", "E")
		
		config.set_value("audio", "master_volume", 1.0)
		config.set_value("audio", "sfx_volume", 1.0)
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)
		
func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)
	
func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings
	
func save_audio_setting(key: String, value):
	config.set_value("audio" , key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings
	
func save_keybinding(action: StringName, event: InputEvent):
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
		print("saved")
	elif event is InputEventMouseButton:
		event_str = "mouse_" + str(event.button_index)
		print("saved")
		
	config.set_value("keybinding", action, event_str)
	config.save(SETTINGS_FILE_PATH)
		
func load_keybindings():
	var keybindings = {}
	var keys = config.get_section_keys("keybinding")
	for key in keys:
		var input_event
		var event_str = config.get_value("keybinding", key)
		
		if event_str.contains("mouse_"):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_str.split("_")[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
			
		keybindings[key] = input_event
	return keybindings
