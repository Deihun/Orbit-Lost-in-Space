extends Node2D

@onready var eventReader = $Event_UI
@onready var Cycle = $"/root/IngameStoredProcessSetting"
@onready var OpeningAnimation = $EventUIAnimation

var Active = true
var Critical_Event = []
var rawEvent = []
var alreadyTriggeredEvent = []
var Priority_Event = []
var eventID = []
var isEventVisible = false
var onlyOnceTrigger = true
var currentActiveQueue : int = 0


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
	isEventVisible = !isEventVisible
	if isEventVisible == true:
		OpeningAnimation.visible = true
		OpeningAnimation.play("OpeningAnimation")
	elif isEventVisible == false:
		eventReader.visible = false
		OpeningAnimation.visible = true
		OpeningAnimation.play("ClosingAnimation")
	pass

func _on_opening_ui_scene_animation_finished() -> void:
	if isEventVisible:
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
	currentActiveQueue = numbers_of_event
	#_CRITICAL EVENT
	while(Critical_Event.size() > 0):
		var Critical_key = Critical_Event.pop_front()
		for eachEvent in rawEvent:
			if eachEvent.has("Conditions"):
				if eachEvent["Conditions"][0] == "CRITICAL" && eachEvent["Conditions"][1].has(Critical_key):
					eventID.append(eachEvent["id"])
	#PRIORITIZE EVENTS THAT WITHIN PRIORITY ARRAY
	while(Priority_Event.size() > 0 && numbers_of_event > 0): 
		var priority_key = Priority_Event.pop_front()
		for eachEvent in rawEvent:
			if eachEvent.has("Conditions"):
				if eachEvent["Conditions"][0] == "FOLLOW-UP" && eachEvent["Conditions"][1].has(priority_key):
					eventID.append(eachEvent["id"])
					numbers_of_event -= 1
	
	#ADD EVENTS BASE ON LIMIT PER CYCLE
	for i in numbers_of_event: 
		#ADD EVENTS BASE ON LIMIT PER CYCLE
		_addNextEvent()


func _addNextEvent():
	var event_index_random = randi() % rawEvent.size()
	var event = rawEvent[event_index_random]
	var globalResources = $"/root/GlobalResources"
	
	if event["RandomTrue"] != true: #FILTER IF EVENTS CAN BE ACTIVATED
		_addNextEvent()
		return
	if event["Repeatable"] == false: #FILTER IF EVENTS CAN BE REPEATED
		if !alreadyTriggeredEvent.has(event["id"]):
			alreadyTriggeredEvent.append(event["id"])
		else:
			_addNextEvent()
			return
	if event.has("Conditions"): #FILTER IF EVENT HAS CONDITIONS AND IF IT WAS SATISFIED
		if event["Conditions"][0] == ("PLACE"):
			if !event["Conditions"][1][0].has(globalResources.place):
				_addNextEvent()
				return
	eventID.append(event["id"])


func ActivateEvent(): #ACTIVATE QUEUE EVENT
	print( "already instantiate: ",alreadyTriggeredEvent)
	if eventID.front() == null:
		switchIt()
		return
	eventReader.setEventID(eventID.pop_front())
	eventReader.processNextEvent()


func _removeAllEvent(): #CLEAR ALL EVENT
	eventID.clear()


#RETURNING METHODS
func getAllEventIDHierarchy():
	eventReader.setEventID(eventID)

func addFollowUpEvent(event):
	Priority_Event.append(event)
