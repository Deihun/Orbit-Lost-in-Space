class_name SettingsMenu
extends Control

@onready var back_button = $VBoxContainer/Back_button as Button

signal back_settings_menu
# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.pressed.connect(on_back_pressed)


func on_back_pressed() -> void:
	$".".visible = false
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
