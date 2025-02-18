class_name MainMenu
extends Control

@onready var new_game_button = $Control/New_Game_Button as Button
@onready var load_game_button = $Control/Load_Game_Button as Button
@onready var settings_button = $Control/Settings_Button as Button
@onready var settings_menu = $Settings_Menu as SettingsMenu
@onready var save_ui = $SaveUI
@onready var margin_container = $MarginContainer as MarginContainer
@onready var quit_button = $Control/Quit_Button as Button
@onready var start_game = load("res://Scenes/LoadingScene.tscn") as PackedScene
@onready var load_game = load("res://Scenes/TestingInteriorScene.tscn") as PackedScene
@onready var a = preload("res://Scripts/EventManager_NotIngame.tscn") as PackedScene
@onready var tutorialScene = preload("res://Scenes/Tutorial/TutorialScene.tscn")
@onready var LoadGame = SaveNLoad
@onready var credits: Control = $Credits

func _ready() -> void:
	$AnimationPlayer.play("Start_up")
	save_ui.hidenodeMain()
	if !FileAccess.file_exists("user://gallery.json"):
		Create_gallery_data()

var json_data = {}

func load_json_file():
	var file = FileAccess.open("res://Gallery/gallery.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var json = JSON.new()
		var parse_result = json.parse(json_text)
		if parse_result == OK:
			json_data = json.data  # Use `json.data` to get the parsed result
		else:
			print("Failed to parse JSON")
		file.close()
	else:
		print("Failed to load file")

func Create_gallery_data():
	load_json_file()
	var file = FileAccess.open("user://gallery.json", FileAccess.WRITE)
	if file:
		var json_text = JSON.stringify(json_data)
		file.store_string(json_text)
		file.close()
	else:
		print("Failed to save file")

func _on_new_game_button_pressed() -> void:
	if SettingsDataContainer.tutorialScene or SettingsDataContainer.tutorialScene == null:
		SettingsDataContainer.tutorialScene = false
		SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
		IngameStoredProcessSetting.Scenes = "tutorial"
		get_tree().change_scene_to_packed(start_game)
		pass
	else:
		IngameStoredProcessSetting.Scenes = "newgame"
		get_tree().change_scene_to_packed(start_game)

func _on_load_game_button_pressed():
		if save_ui.visible == true:
			save_ui.visible = false
		else:
			save_ui.visible = true

func _on_settings_button_pressed():
	save_ui.visible = false
	margin_container.visible = false
	settings_menu.visible = true
	settings_menu.set_process(true)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func on_back_settings_menu() -> void:
	save_ui.visible = false
	margin_container.visible = true
	settings_menu.visible = false
	
	
func _on_developer_option_pressed() -> void:
	get_tree().change_scene_to_packed(a)
	

func _on_credits_button_pressed() -> void:
	if credits.visible == true:
		credits.visible = false
		print("open")
	else:
		credits.visible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("openCommand"):
		$Control/DeveloperOption.visible = !$Control/DeveloperOption.visible


func _on_gallery_button_up() -> void:
	var a = preload("res://Gallery/gallery.tscn").instantiate()
	a.z_index = 50
	$".".add_child(a)
