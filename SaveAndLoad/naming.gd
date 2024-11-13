extends Control

@onready var text_edit: TextEdit = $HBoxContainer/TextEdit
@onready var save: Button = $HBoxContainer/Save
@onready var delete: Button = $HBoxContainer/Delete
@onready var saveGame = SaveNLoad
@onready var save_ui: Control = $".."
@onready var message_delay = get_parent().get_node("NinePatchRect/Panel/MessageDelaySave")
@onready var panel: Panel = $"../NinePatchRect/Panel"

var filename


func set_file_name():
	filename = text_edit.text

func save_file():
	#if save_ui.Files.has(text_edit.text):
	if not text_edit.text == "":
		saveGame.SaveGame(filename)
		saveGame.save()
		save_ui.update_all()
	else: 
		panel.visible = true
		message_delay.start()
		save_ui.start_custom_timer()
	#else:

func _on_save_pressed() -> void:
	set_file_name()
	save_file()
	text_edit.text = ""
