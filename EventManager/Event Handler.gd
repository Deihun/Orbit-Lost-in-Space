extends Node2D

@onready var eventReader = $Event_UI
@onready var Cycle = $"/root/IngameStoredProcessSetting"
@onready var OpeningAnimation = $EventUIAnimation

var rawEvent = []
var isEventVisible = false
var onlyOnceTrigger : bool = true
var onceTutorial : bool = false

					#NON RETURNING METHODS
#SETUP ZONES
func _ready():
	var file_path = "res://Scripts/Events.json"
	if(FileAccess.file_exists(file_path)):
		var file = FileAccess.open(file_path,FileAccess.READ)
		var json_text = file.get_as_text()
		rawEvent = parse_json(json_text)
	else: 
		print("EVENT-HANDLER-SCRIPT://  'func _ready()' : 'Failed to locate'")
	startAddNextEvent()
	ActivateEvent()


func parse_json(json_text):
	var json = JSON.new()
	var result = json.parse(json_text)
	if result != OK:
		print("EVENT-HANDLER-SCRIPT://  'parse_json' : 'Failed to analyze json file'", json.get_error_line())
		return []
	return json.get_data()

func switchIt():
	if isEventVisible == true:
		print("Event SHOWING;")
		OpeningAnimation.visible = true
		OpeningAnimation.play("OpeningAnimation")
	elif isEventVisible == false:
		print("Event Hiding;")
		eventReader.visible = false
		OpeningAnimation.visible = true
		OpeningAnimation.play("ClosingAnimation")
		if !onceTutorial:
			var tutorialEnd = NodeFinder.find_node_by_name(get_tree().current_scene,"TutorialPanel4")
			onceTutorial = true
			if tutorialEnd:
				tutorialEnd.visible = true
			
	pass

func _on_opening_ui_scene_animation_finished() -> void:
	if isEventVisible:
		print("DAPAT LUMABAS KA HAYOP KA")
		visible = true
		eventReader.visible = true
	else: 
		visible = false
	OpeningAnimation.visible = false


func _newGameStart():
	pass


func _loadGameStart(eventLoads):
	pass


#EVENTS METHODS
func startAddNextEvent(): #ADD EVENT ON QUEUE
	onlyOnceTrigger = true
	self.visible = true
	var numbers_of_event =  int(1 + (randf() * (Cycle.getCycle()*0.08)))
	GlobalResources.currentActiveQueue = numbers_of_event
	
	#_CRITICAL EVENT
	while(GlobalResources.Critical_Event.size() > 0):
		var Critical_key = GlobalResources.Critical_Event.pop_front()
		for eachEvent in rawEvent:
			if eachEvent.has("Conditions"):
				if eachEvent["Conditions"][0] == "CRITICAL" && eachEvent["Conditions"][1].has(Critical_key):
					GlobalResources.eventID.append(eachEvent["id"])
	#PRIORITIZE EVENTS THAT WITHIN PRIORITY ARRAY
	while(GlobalResources.Priority_Event.size() > 0 && numbers_of_event > 0): 
		var priority_key = GlobalResources.Priority_Event.pop_front()
		for eachEvent in rawEvent:
			if eachEvent.has("Conditions"):
				if eachEvent["Conditions"][0] == "FOLLOW-UP" && eachEvent["Conditions"][1].has(priority_key):
					GlobalResources.eventID.append(eachEvent["id"])
					numbers_of_event -= 1
	
	#ADD EVENTS BASE ON LIMIT PER CYCLE
	for i in numbers_of_event: 
		#ADD EVENTS BASE ON LIMIT PER CYCLE
		_addNextEvent()


func _conditions(eachEvent):
	if eachEvent.has("Conditions"):
		var data = str(eachEvent["Conditions"][1]).capitalize()
		#HAS CONDITION
		if eachEvent["Conditions"][0] == "HAS":
			if GlobalResources.hasItem(eachEvent["Conditions"][1],1):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		#RELATIONSHIP CONDITION
		elif eachEvent["Conditions"][0] == "RELATIONSHIP_MAX_WITH_ME":
			if IngameStoredProcessSetting.isRelationship(data, 1.0):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		elif eachEvent["Conditions"][0] == "RELATIONSHIP_HIGH_75%_WITH_ME":
			if IngameStoredProcessSetting.isRelationship(data, 0.75):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		elif eachEvent["Conditions"][0] == "RELATIONSHIP_LOWER_25%_WITH_ME":
			if IngameStoredProcessSetting.isRelationship(data,0.25,false):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		elif eachEvent["Conditions"][0] == "RELATIONSHIP_LOWER_0%_WITH_ME":
			if IngameStoredProcessSetting.isRelationship(data,0.0,false):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		#SANITY
		elif eachEvent["Conditions"][0] == "SANITY_100%":
			if IngameStoredProcessSetting.isSanity(data,1.0):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		elif eachEvent["Conditions"][0] == "SANITY_75%":
			if IngameStoredProcessSetting.isSanity(data,0.75):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		elif eachEvent["Conditions"][0] == "SANITY_25%":
			if IngameStoredProcessSetting.isSanity(data, 0.25,false):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		elif eachEvent["Conditions"][0] == "SANITY_0%":
			if IngameStoredProcessSetting.isSanity(data,0.0, false):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		#PLACE
		elif eachEvent["Conditions"][0] == "PLACE":
			if IngameStoredProcessSetting.current_Factions == str(data):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		#HAS INGAME EFFECTS
		elif eachEvent["Conditions"][0] == "HAS_INGAME_EFFECTS":
			if GlobalResources.GameEffects.has(data):
				GlobalResources.eventID.append(eachEvent["id"])
				return
		#HAS UNIQUE ITEMS
		elif eachEvent["Conditions"][0] == "HAS_UNIQUE_ITEM":
			if GlobalResources.uniqueItems.has(data):
				GlobalResources.eventID.append(eachEvent["id"])
				return
	_addNextEvent()



func _addNextEvent():
	
	var event_index_random = randi() % rawEvent.size()
	var event = rawEvent[event_index_random]
	var globalResources = $"/root/GlobalResources"
	print(event["RandomTrue"], " id: ", event["id"]," - ", event["Repeatable"] == false," - " ,event.has("Conditions"))
	if event["RandomTrue"] != true: #FILTER IF EVENTS CAN BE ACTIVATED
		
		_addNextEvent()
		return
	if event["Repeatable"] == false: #FILTER IF EVENTS CAN BE REPEATED
		if !GlobalResources.alreadyTriggeredEvent.has(event["id"]):
			GlobalResources.alreadyTriggeredEvent.append(event["id"])
		else:
			_addNextEvent()
			return
	if event.has("Conditions"): #FILTER IF EVENT HAS CONDITIONS AND IF IT WAS SATISFIED
		_conditions(event)
	GlobalResources.eventID.append(event["id"])


func ActivateEvent(): #ACTIVATE QUEUE EVENT
	print("DEBUG: " ,GlobalResources.eventID)
	if GlobalResources.eventID.front() == null:
		isEventVisible = false
		switchIt()
		return
	isEventVisible = true
	eventReader.setEventID(GlobalResources.eventID.pop_front())
	eventReader.processNextEvent()


func _removeAllEvent(): #CLEAR ALL EVENT
	GlobalResources.eventID.clear()


#RETURNING METHODS
func getAllEventIDHierarchy():
	eventReader.setEventID(GlobalResources.eventID)

func addFollowUpEvent(event):
	GlobalResources.Priority_Event.append(event)
