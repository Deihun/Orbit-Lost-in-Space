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
