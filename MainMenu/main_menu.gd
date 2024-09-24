class_name MainMenu
extends Control

@onready var new_game_button = $MarginContainer/HBoxContainer/VBoxContainer/New_Game_Button as Button
@onready var load_game_button = $MarginContainer/HBoxContainer/VBoxContainer/Load_Game_Button as Button
@onready var settings_button = $MarginContainer/HBoxContainer/VBoxContainer/Settings_Button as Button
@onready var settings_menu = $Settings_Menu as SettingsMenu
@onready var margin_container = $MarginContainer as MarginContainer
@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/Quit_Button as Button
@onready var start_game = load("res://Scenes/LoadingScene.tscn") as PackedScene
@onready var LoadGame = SaveNLoad


# Called when the node enters the scene tree for the first time.
func _ready():
	handler_connect_signals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_game)

func _on_load_game_button_pressed():
	LoadGame.load()

func _on_settings_button_pressed():
	
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func on_back_settings_menu() -> void:
	margin_container.visible = true
	settings_menu.visible = false
	
func handler_connect_signals() -> void:
	new_game_button.pressed.connect(_on_new_game_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	settings_menu.back_settings_menu.connect(on_back_settings_menu)
