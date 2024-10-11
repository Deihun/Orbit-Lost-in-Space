extends Node2D




func _ready() -> void:
	pass # Replace with function body.

func addData(data : int, _bool : bool):
	match(data):
		1:
			SettingsDataContainer.tutorialPanel_1 = _bool
		2:
			SettingsDataContainer.tutorialPanel_2 = _bool
		3:
			SettingsDataContainer.tutorialPanel_3 = _bool
		4:
			SettingsDataContainer.tutorialPanel_4 = _bool
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
