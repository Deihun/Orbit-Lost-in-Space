extends Control

@onready var load_game = load("res://Scenes/TestingInteriorScene.tscn") as PackedScene
@onready var label: Label = $ColorRect/HBoxContainer/Label as Label
@onready var SaveGame = SaveNLoad
@onready var save_ui: Control = $"."
@onready var button_sfx: AudioStreamPlayer = $ButtonSfx

var FileName : String = "hello"
var SaveName

func _ready() -> void:
	set_action_name()
	
func set_action_name() -> void:
	label.text = FileName
	SaveName = label.text

func _on_button_pressed() -> void:
	button_sfx.play()
	SaveGame.LoadSave(SaveName)
	SaveNLoad.isLoadGame = true
	get_tree().change_scene_to_packed(load_game)

func _on_delete_pressed() -> void:
	button_sfx.play()
	var deleteName = label.text
	var Path = "Saves/" + deleteName +".json"
	var PathName = deleteName +".json"
	
	if FileAccess.file_exists(Path):
		var dir = DirAccess.open("res://Saves/")
		if dir:
			var error = dir.remove(PathName)
			if error == OK:
				print("File deleted successfully.")
				get_tree().reload_current_scene()
			else:
				print("Failed to delete the file.")
		else:
			print("File does not exist.")
	else:
		print("Failed to access directory.")
