class_name SettingsMenu
extends Control

func _on_back_button_pressed() -> void:
	self.visible = false
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
