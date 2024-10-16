extends Node

@onready var resources = GlobalResources
@onready var events = NodeFinder.find_node_by_name(get_tree().current_scene,"EventHandler")
var SavePath = "Saves/GameSave.json"
var isLoadGame : bool

var event_dictionary = {}
var critical
var rawEvent
var alreadyTriggeredEvent
var Priority_Event
var eventID

func _process(delta: float) -> void:
	if !events:
		events = NodeFinder.find_node_by_name(get_tree().current_scene,"EventHandler")

func LoadSave(SaveName : String) -> void:
	SavePath = "Saves/" + SaveName +".json"
	loadsave()
	print(SavePath)

func SaveGame(SaveName : String):
	SavePath = "Saves/" + SaveName +".json"
	save()
	print(SavePath)

func savedata():
	#print("test")
	if !events :
		print("null save")
	var save_dict = {
		"ration" : resources.ration,
		"oxygen" : resources.oxygen,
		"fuel" : resources.fuel,
		"spareparts" : resources.spareparts,
		"biogene" : resources.biogene,
		"ductape" : resources.ductape,
		"emergencyOxy" : resources.emergencyOxy,
		"emergencyFuel" : resources.emergencyFuel,
		"GameEffects" : resources.GameEffects,
		"uniqueItems" : resources.uniqueItems,
		"Location" : resources.Location,
		"Critical_Event" : resources.Critical_Event,
		"alreadyTriggeredEvent" : resources.alreadyTriggeredEvent,
		"Priority_Event" : resources.Priority_Event,
		"eventID" : resources.eventID
	}
	return save_dict

func save():
	print("saved")
	var file = FileAccess.open(SavePath, FileAccess.WRITE)
	#var file = FileAccess.open_encrypted_with_pass(SavePath, FileAccess.WRITE, "Orbit")
	var json_string = JSON.stringify(savedata())
	file.store_line(json_string)
	
func loadsave():
	if not FileAccess.file_exists(SavePath):
		print("file exsit")
		return
	var file = FileAccess.open(SavePath, FileAccess.READ)
	#var file = FileAccess.open_encrypted_with_pass(SavePath, FileAccess.READ, "Orbit")
		
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()	
		
		resources.ration = node_data["ration"]
		resources.oxygen = node_data["oxygen"]
		resources.fuel = node_data["fuel"]
		resources.spareparts = node_data["spareparts"]
		resources.biogene = node_data["biogene"]
		resources.ductape = node_data["ductape"]
		resources.emergencyOxy = node_data["emergencyOxy"]
		resources.emergencyFuel = node_data["emergencyFuel"]
		resources.GameEffects = node_data["GameEffects"]
		resources.uniqueItems = node_data["uniqueItems"]
		resources.Location = node_data["Location"]
		resources.Critical_Event = node_data["Critical_Event"]
		resources.alreadyTriggeredEvent = node_data["alreadyTriggeredEvent"]
		resources.Priority_Event = node_data["Priority_Event"]
		resources.eventID = node_data["eventID"]
