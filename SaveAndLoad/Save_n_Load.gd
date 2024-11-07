extends Node

@onready var resources = GlobalResources
@onready var stored = IngameStoredProcessSetting
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
	if !events :
		print("null save")
	var save_dict = {
		#Set Save data values to File save
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
		"eventID" : resources.eventID,
		
		"cycle" : stored.Cycle,
		"_relationship" : stored._relationship.duplicate(),
		"_currentHunger" : stored._current_hunger.duplicate(),
		"already_eaten" : stored.already_eaten.duplicate(),
		"crew_in_ship" : stored.crew_in_ship.duplicate(),
		"jerry_ate_countdown" : stored.jerry_ate_countdown,
		"already_medicine" : stored.already_medicine.duplicate(),
		"already_talk" : stored.already_talk.duplicate(),
		"_sanity" : stored._sanity.duplicate(),
		"_health" : stored._health.duplicate(),
		"_disease" : stored._disease.duplicate(),
		"_reginaRelationship" : stored._reginaRelationship.duplicate(),
		"_MaximRelationship" : stored._MaximRelationship.duplicate(),
		"_NashirRelationship"  : stored._NashirRelationship.duplicate(),
		"_FumikoRelationship" : stored._reginaRelationship.duplicate(),
		
		"delayInFaction" : stored.delayInFaction,
		"current_Factions" : stored.current_Factions,
		"TravelPerSections" : stored.TravelPerSections,
		"Target_factions" : stored.Target_factions,
		"TotalProbabilityForFactionsToFound" : stored.TotalProbabilityForFactionsToFound,
		"Factions_Probability" : stored.Factions_Probability.duplicate(),
		"SubFactions_Probability" : stored.SubFactions_Probability.duplicate(),
		
		"Cycle_ReportList" : stored.Cycle_ReportList.duplicate(),
		"recent_events" : stored.recent_events.duplicate()
	}
	return save_dict

func save():
	print("saved")
	var file = FileAccess.open_encrypted_with_pass(SavePath, FileAccess.WRITE, "Orbit")
	var json_string = JSON.stringify(savedata())
	file.store_line(json_string)
	
func loadsave():
	if not FileAccess.file_exists(SavePath):
		print("file exsit")
		return
	var file = FileAccess.open_encrypted_with_pass(SavePath, FileAccess.READ, "Orbit")
		
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()	
		#Get Value from save file
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
		
		stored.Cycle = node_data["cycle"]
		stored._relationship = node_data["_relationship"].duplicate()
		stored._current_hunger = node_data["_currentHunger"].duplicate()
		stored.already_eaten= node_data["already_eaten"].duplicate()
		stored.crew_in_ship = node_data["crew_in_ship"].duplicate()
		
		stored.jerry_ate_countdown = node_data["jerry_ate_countdown"]
		stored.already_medicine = node_data["already_medicine"].duplicate()
		stored.already_talk = node_data["already_talk"].duplicate()
		stored._sanity = node_data["_sanity"].duplicate()
		stored._health = node_data["_health"].duplicate()
		stored._disease = node_data["_disease"].duplicate()
		stored._reginaRelationship = node_data["_reginaRelationship"].duplicate()
		stored._MaximRelationship = node_data["_MaximRelationship"].duplicate()
		stored._NashirRelationship = node_data["_NashirRelationship"].duplicate()
		stored._FumikoRelationship = node_data["_FumikoRelationship"].duplicate()
		
		stored.delayInFaction = node_data["delayInFaction"]
		stored.current_Factions = node_data["current_Factions"]
		stored.TravelPerSections = node_data["TravelPerSections"]
		stored.Target_factions = node_data["Target_factions"]
		stored.TotalProbabilityForFactionsToFound = node_data["TotalProbabilityForFactionsToFound"]
		stored.Factions_Probability = node_data["Factions_Probability"].duplicate()
		stored.SubFactions_Probability = node_data["SubFactions_Probability"].duplicate()
		stored.Cycle_ReportList = node_data["Cycle_ReportList"].duplicate()
		stored.recent_events = node_data["recent_events"].duplicate()
