extends Node2D

@onready var eventReader = $EventReader
@onready var Cycle = $"/root/IngameStoredProcessSetting"
@onready var OpeningAnimation = $EventUIAnimation

var rawEvent = []
var isEventVisible = false
var onlyOnceTrigger : bool = true
var onceTutorial : bool = false
var isTextToSpeechOn : bool = false
var recentAnimation = ""
var voices = DisplayServer.tts_get_voices()
var initialDescription = ""

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


func parse_json(json_text):
	var json = JSON.new()
	var result = json.parse(json_text)
	if result != OK:
		print("EVENT-HANDLER-SCRIPT://  'parse_json' : 'Failed to analyze json file'", json.get_error_line())
		return []
	return json.get_data()

func switchIt(value : bool = true):
	eventReader.hide()
	if value:	#OPENING
		OpeningAnimation.stop()
		eventReader.hide()
		OpeningAnimation.show()
		OpeningAnimation.play("OpeningAnimation")
		recentAnimation = "OpeningAnimation"

	else: #CLOSING
		DisplayServer.tts_stop()
		OpeningAnimation.stop()
		eventReader.hide()
		OpeningAnimation.show()
		OpeningAnimation.play("ClosingAnimation")
		recentAnimation = "ClosingAnimation"



func _on_opening_ui_scene_animation_finished() -> void:
	if recentAnimation == "OpeningAnimation":
		OpeningAnimation.show()
		eventReader.show()
		_triggerDialogue(initialDescription, isTextToSpeechOn)
	elif recentAnimation == "ClosingAnimation": 
		OpeningAnimation.hide()
		eventReader.hide()



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
				if eachEvent["Conditions"][0] == "CRITICAL" and Critical_key in eachEvent["Conditions"][1]:
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


func _conditions(eachEvent) -> bool:
	var condition = true
	if eachEvent.has("Conditions"):
		var data = str(eachEvent["Conditions"][1]).capitalize()
		#HAS CONDITION
		if eachEvent["Conditions"][0] == "HAS":
			if GlobalResources.hasItem(eachEvent["Conditions"][1],1):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		#RELATIONSHIP CONDITION
		elif eachEvent["Conditions"][0] == "RELATIONSHIP_MAX_WITH_ME":
			if IngameStoredProcessSetting.isRelationship(data, 1.0):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		elif eachEvent["Conditions"][0] == "RELATIONSHIP_HIGH_75%_WITH_ME":
			if IngameStoredProcessSetting.isRelationship(data, 0.75):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		elif eachEvent["Conditions"][0] == "RELATIONSHIP_LOWER_25%_WITH_ME":
			if IngameStoredProcessSetting.isRelationship(data,0.25,false):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		elif eachEvent["Conditions"][0] == "RELATIONSHIP_LOWER_0%_WITH_ME":
			if IngameStoredProcessSetting.isRelationship(data,0.0,false):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		#SANITY
		elif eachEvent["Conditions"][0] == "SANITY_100%":
			if IngameStoredProcessSetting.isSanity(data,1.0):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		elif eachEvent["Conditions"][0] == "SANITY_75%":
			if IngameStoredProcessSetting.isSanity(data,0.75):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		elif eachEvent["Conditions"][0] == "SANITY_25%":
			if IngameStoredProcessSetting.isSanity(data, 0.25,false):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		elif eachEvent["Conditions"][0] == "SANITY_0%":
			if IngameStoredProcessSetting.isSanity(data,0.0, false):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		#PLACE
		elif eachEvent["Conditions"][0] == "PLACE":
			if IngameStoredProcessSetting.current_Factions == str(data):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		#HAS INGAME EFFECTS
		elif eachEvent["Conditions"][0] == "HAS_INGAME_EFFECTS":
			if GlobalResources.GameEffects.has(data):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
		#HAS UNIQUE ITEMS
		elif eachEvent["Conditions"][0] == "HAS_UNIQUE_ITEM":
			if GlobalResources.uniqueItems.has(data):
				GlobalResources.eventID.append(eachEvent["id"])
				return condition
	return false


func _triggerDialogue(SpeechMessagge : String, value : bool, VoiceID : int = 0)-> void:
	if !value: return
	
	var volume =  int(SettingsDataContainer.get_sfx_volume() * 100)
	DisplayServer.tts_stop()
	if !$EventReader.visible and $EventUIAnimation.is_playing():
		await $EventUIAnimation.animation_finished
	DisplayServer.tts_speak(SpeechMessagge,"TTS_MS_EN-US_DAVID_11.0",volume)
	pass


func _addNextEvent()-> void :
	var _event
	while true:
		var event_index_random = randi() % rawEvent.size()
		var event = rawEvent[event_index_random]
		var globalResources = $"/root/GlobalResources"
		_event = event
		if event["RandomTrue"] == true:
			if event["Repeatable"] == true or !GlobalResources.alreadyTriggeredEvent.has(event["id"]):
				if event.has("Conditions"):
					if _conditions(event):
						break  # Exit loop if the event is valid
				else:
					break  # Exit loop if there are no conditions
	GlobalResources.eventID.append(_event["id"])
	if _event["Repeatable"] == false:
		GlobalResources.alreadyTriggeredEvent.append(_event["id"])


func ActivateEvent(): #ACTIVATE QUEUE EVENT
	if GlobalResources.eventID.front() == null:
		isEventVisible = false
		switchIt(false)
		var endCycle = $"../cam2d/Button_navigation_node_parent/EndCycle"
		var control = get_parent()
		endCycle.enable()
		control.EndCycle_Can_Be_Click_ = true
		if !onceTutorial:
			var tutorialEnd = NodeFinder.find_node_by_name(get_tree().current_scene,"TutorialPanel4")
			onceTutorial = true
			if tutorialEnd:
				tutorialEnd.visible = true

		return
	var CurrentEventID = GlobalResources.eventID.pop_front()
	isEventVisible = true
	eventReader.setEventID(CurrentEventID)
	eventReader.processNextEvent()
	var description = ""
	for event in rawEvent:
		if event.has("id") and event["id"] == CurrentEventID:
			description = event.get("description","no description found")
	initialDescription = description



func _removeAllEvent(): #CLEAR ALL EVENT
	GlobalResources.eventID.clear()


#RETURNING METHODS
func getAllEventIDHierarchy():
	eventReader.setEventID(GlobalResources.eventID)

func addFollowUpEvent(event):
	GlobalResources.Priority_Event.append(event)

func _is_in_event_index(target_data : int) -> bool:
	for entry in rawEvent:
		if entry.has("id") and entry["id"] == target_data:
			return true
	return false


func _on_volume_switch_button_up() -> void:
	isTextToSpeechOn = !isTextToSpeechOn
	if isTextToSpeechOn: $EventReader/VolumeSwitch/Volume.texture = load("res://Scenes/Ingame/VolumeOn_EventUI.png")
	else: $EventReader/VolumeSwitch/Volume.texture = load("res://Scenes/Ingame/VolumeOff_EventUI.png")
	pass # Replace with function body.
