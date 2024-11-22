extends Node

@onready var DEFAULT_SETTINGS : DefaultSettingsResource = preload("res://Resources/settings/DefaultSettings.tres")
@onready var keybind_resource : PlayerKeybindResource = preload("res://settings_menu/PlayerKeybindDefault.tres")

var window_mode_index : int = 0
var resolution_index : int = 0
var master_volume : float = 0.0
var music_volume : float = 0.0
var sfx_volume : float = 0.0
var tutorial_set : bool = true
var tutorialScene: bool = true
var tutorialPanel_1 : bool = true
var tutorialPanel_2 : bool = true
var tutorialPanel_3 : bool = true
var tutorialPanel_4 : bool = true
var loaded_data : Dictionary = {}

func _ready() -> void:
	handle_signals()
	create_storage_dictionary()

func create_storage_dictionary() -> Dictionary:
	var settings_container_dict : Dictionary = {
		"window_mode_index" : window_mode_index,
		"resolution_index" : resolution_index,
		"master_volume" : master_volume,
		"music_volume" : music_volume,
		"sfx_volume" : sfx_volume,
		"keybinds" : create_keybind_dictionary(),
		"TutorialScene" : tutorialScene,
		"TutorialPanel1" : tutorialPanel_1,
		"TutorialPanel2" : tutorialPanel_2,
		"TutorialPanel3" : tutorialPanel_3,
		"TutorialPanel4" : tutorialPanel_4
	}
	return settings_container_dict

func create_keybind_dictionary() -> Dictionary:
	var keybinds_container_dict = {
		keybind_resource.MOVE_LEFT : keybind_resource.ui_left_key,
		keybind_resource.MOVE_RIGHT : keybind_resource.ui_right_key,
		keybind_resource.MOVE_UP : keybind_resource.ui_up_key,
		keybind_resource.MOVE_DOWN : keybind_resource.ui_down_key,
		keybind_resource.INTERACT : keybind_resource.Interact_key
	}
	return keybinds_container_dict

func get_window_mode_index() -> int:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_WINDOW_MODE_INDEX
	return window_mode_index

func get_resolution_index() -> int:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_RESOLUTION_INDEX
	return resolution_index
	
func get_master_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MASTER_VOLUME
	return master_volume
	
func get_music_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MUSIC_VOLUME
	return music_volume

func get_sfx_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SFX_VOLUME
	return sfx_volume

func get_keybind(action : String):
	if !loaded_data.has("keybinds"):
		match action:
			keybind_resource.MOVE_LEFT:
				return keybind_resource.DEFAULT_MOVE_LEFT_KEY
			keybind_resource.MOVE_RIGHT:
				return keybind_resource.DEFAULT_MOVE_RIGHT_KEY
			keybind_resource.MOVE_UP:
				return keybind_resource.DEFAULT_MOVE_UP_KEY
			keybind_resource.MOVE_DOWN:
				return keybind_resource.DEFAULT_MOVE_DOWN_KEY
			keybind_resource.INTERACT:
				return keybind_resource.DEFAULT_INTERACT_KEY
	else:
		match action:
			keybind_resource.MOVE_LEFT:
				return keybind_resource.ui_left_key
			keybind_resource.MOVE_RIGHT:
				return keybind_resource.ui_right_key
			keybind_resource.MOVE_UP:
				return keybind_resource.ui_up_key
			keybind_resource.MOVE_DOWN:
				return keybind_resource.ui_down_key
			keybind_resource.INTERACT:
				return keybind_resource.Interact_key

func on_window_mode_selected(index : int) -> void:
	window_mode_index = index

func on_resolution_selected(index : int) -> void:
	resolution_index = index

func on_master_sound_set(value : float) -> void:
	master_volume = value
	
func on_music_sound_set(value : float) -> void:
	music_volume = value
	
func on_sfx_sound_set(value : float) -> void:
	sfx_volume = value
	
func set_keybind(action : String, event) -> void:
	match action:
		keybind_resource.MOVE_LEFT:
			keybind_resource.ui_left_key = event
		keybind_resource.MOVE_RIGHT:
			keybind_resource.ui_right_key = event
		keybind_resource.MOVE_UP:
			keybind_resource.ui_up_key = event
		keybind_resource.MOVE_DOWN:
			keybind_resource.ui_down_key = event
		keybind_resource.INTERACT:
			keybind_resource.Interact_key = event

func on_keybinds_loaded(data : Dictionary) -> void:
	var loaded_move_left = InputEventKey.new()
	var loaded_move_right = InputEventKey.new()
	var loaded_move_up = InputEventKey.new()
	var loaded_move_down = InputEventKey.new()
	var loaded_interact = InputEventKey.new()
	
	loaded_move_left.set_physical_keycode(int(data.ui_left))
	loaded_move_right.set_physical_keycode(int(data.ui_right))
	loaded_move_up.set_physical_keycode(int(data.ui_up))
	loaded_move_down.set_physical_keycode(int(data.ui_down))
	loaded_interact.set_physical_keycode(int(data.Interact))
	
	keybind_resource.ui_left_key = loaded_move_left
	keybind_resource.ui_right_key = loaded_move_right
	keybind_resource.ui_up_key = loaded_move_up
	keybind_resource.ui_down_key = loaded_move_down
	keybind_resource.Interact_key = loaded_interact

func on_settings_data_loaded(data : Dictionary) -> void:
	loaded_data = data
	on_window_mode_selected(loaded_data.window_mode_index)
	on_resolution_selected(loaded_data.resolution_index)
	on_master_sound_set(loaded_data.master_volume)
	on_music_sound_set(loaded_data.music_volume)
	on_sfx_sound_set(loaded_data.sfx_volume)
	on_keybinds_loaded(loaded_data.keybinds)
	
func handle_signals() -> void:
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
	SettingsSignalBus.load_settings_data.connect(on_settings_data_loaded)
