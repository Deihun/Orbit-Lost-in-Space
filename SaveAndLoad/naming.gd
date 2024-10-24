extends Control

@onready var text_edit: TextEdit = $HBoxContainer/TextEdit
@onready var save: Button = $HBoxContainer/Save
@onready var delete: Button = $HBoxContainer/Delete
@onready var saveGame = SaveNLoad
@onready var save_ui: Control = $".."
@onready var message_delay: Timer = $"../NinePatchRect/Panel/MessageDelay"
@onready var panel: Panel = $"../NinePatchRect/Panel"

var filename


func set_file_name():
	filename = text_edit.text

func save_file():
	if not text_edit.text == "":
		saveGame.SaveGame(filename)
		saveGame.save()
		save_ui.update_all()
	else: 
		panel.visible = true
		message_delay.start()

func _on_save_pressed() -> void:
	set_file_name()
	save_file()
	text_edit.text = ""
