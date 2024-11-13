extends Control

@onready var load_game = load("res://Scenes/TestingInteriorScene.tscn") as PackedScene
@onready var label: Label = $ColorRect/HBoxContainer/Label as Label
@onready var SaveGame = SaveNLoad
@onready var save_ui
var FileName : String = "hello"
var SaveName

func _ready() -> void:
	save_ui = NodeFinder.find_node_by_name(get_tree().current_scene, "SaveUI")
	set_action_name()
	
func set_action_name() -> void:
	label.text = FileName
	SaveName = label.text

func _on_button_pressed() -> void:
	SaveGame.LoadSave(SaveName)
	SaveNLoad.isLoadGame = true
	get_tree().change_scene_to_packed(load_game)

func _on_delete_pressed() -> void:
	var deleteName = label.text
	var Path = "Saves/" + deleteName +".json"
	var PathName = deleteName +".json"
	
	if FileAccess.file_exists(Path):
		var dir = DirAccess.open("res://Saves/")
		if dir:
			var error = dir.remove(PathName)
			if error == OK:
				save_ui.update_all()
			else:
				print("Failed to delete the file.")
		else:
			print("File does not exist.")
	else:
		print("Failed to access directory.")
