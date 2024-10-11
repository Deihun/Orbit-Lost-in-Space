extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_reset_tutorial_button_down() -> void:
	SettingsDataContainer.tutorialScene = true
	SettingsDataContainer.tutorialPanel_1 = true
	SettingsDataContainer.tutorialPanel_2 = true
	SettingsDataContainer.tutorialPanel_3 = true
	SettingsDataContainer.tutorialPanel_4 = true
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	pass # Replace with function body.
