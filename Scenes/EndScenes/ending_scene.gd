extends Node2D

var endTitle : String

var canBeClickAgain : bool = true

# Instance of JSONHandler

# Data structures to hold gallery and facts data
var images = []

func _ready() -> void:
	load_json_file()
	endTitle = IngameStoredProcessSetting.Ending
	$img_Ending.texture = getScene(endTitle)
	DialogueManager.show_dialogue_balloon(Dialogue, endTitle)
	save_json_file()
	pass


#####
var Dialogue = preload("res://DialogueSystem/End.dialogue")

var Kickout_scene = preload("res://Scenes/EndScenes/Gallery_Endings/KickOut_EndScene.png")
var lackofresources = preload("res://Scenes/EndScenes/Gallery_Endings/lackofresources.png")
var radontiEnding = preload("res://Scenes/EndScenes/Gallery_Endings/RadontiEnding.png")
var earth2Earth = preload("res://Scenes/EndScenes/Gallery_Endings/Earth2.0.png")
var BlackHole = preload("res://Scenes/EndScenes/Gallery_Endings/BlackHoleEvent.png")
var JerryAlone = preload("res://Scenes/EndScenes/Gallery_Endings/JerryDeath.png")
const CTHULLU_ENDING = preload("res://Scenes/EndScenes/Gallery_Endings/Cthullu Ending.png")
const SAURIA_ENDING = preload("res://Scenes/EndScenes/Gallery_Endings/Sauria Ending.png")
const STEELICUS_ENDSCENE = preload("res://Scenes/EndScenes/Gallery_Endings/SteelicusENDSCENE.png")


func getScene(content : String):
	match content:
		"Kickout":
			$GoodEnd.text = "Bad End"
			unlock_image(3)
			return Kickout_scene
			
		"lackofresources":
			$GoodEnd.text = "Bad End"
			unlock_image(4)
			return lackofresources
		"Radonti":
			$GoodEnd.text = "Good Ending"
			unlock_image(5)
			return radontiEnding
		"Earth2":
			$GoodEnd.text = "Good Ending"
			unlock_image(1)
			return earth2Earth
		"BlackHole":
			$GoodEnd.text = "Bad End"
			unlock_image(0)
			return BlackHole
		"JerryDeath":
			$GoodEnd.text = "Bad End"
			unlock_image(2)
			return JerryAlone
		"CthulluEnding":
			$GoodEnd.text = "Bad End"
			unlock_image(6)
			return CTHULLU_ENDING
		"Sauria":
			$GoodEnd.text = "Bad End"
			unlock_image(7)
			return SAURIA_ENDING
		"Steelicus":
			$GoodEnd.text = "Bad End"
			unlock_image(8)
			return STEELICUS_ENDSCENE


func _on_button_button_up() -> void:
	if !canBeClickAgain: return
	canBeClickAgain = false
	$Panel.modulate.a = 0.0
	$Panel.show()
	while $Panel.modulate.a < 1.0:
		$Panel.modulate.a += 0.05
		await get_tree().create_timer(0.05).timeout
	await get_tree().create_timer(1.5).timeout
	$GoodEnd.show()
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")


var json_data = {}


func load_json_file():
	var file = FileAccess.open("res://Gallery/gallery.json", FileAccess.ModeFlags.READ)
	if file:
		var json_text = file.get_as_text()
		
		# Create a JSON instance and parse
		var json = JSON.new()
		var parse_result = json.parse(json_text)
		
		if parse_result == OK:
			json_data = json.data  # Use `json.data` to get the parsed result
		else:
			print("Failed to parse JSON")
		
		file.close()
	else:
		print("Failed to load file")

func unlock_image(image_id: int):
	print(json_data)
	if image_id >= 0 and image_id < json_data["images"].size():
		json_data["images"][image_id]["unlocked"] = true
	else:
		print("Invalid image ID")
	save_json_file()

func save_json_file():
	var file = FileAccess.open("res://Gallery/gallery.json", FileAccess.ModeFlags.WRITE)
	if file:
		var json_text = JSON.stringify(json_data)
		file.store_string(json_text)
		file.close()
	else:
		print("Failed to save file")
