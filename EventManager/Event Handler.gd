extends Node2D

@onready var eventReader = $Event_UI
@onready var Cycle = $"/root/IngameStoredProcessSetting"
@onready var test = $""


var rawEvent = []
var alreadyTriggeredEvent = []
var Priority_Event = []
var eventID = []


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


func _process(delta):
	pass

func _newGameStart():
	pass

func _loadGameStart(eventLoads):
	pass

func startAddNextEvent():
	self.visible = true
	var numbers_of_event =  int(1 + (randf() * (Cycle.getCycle()*0.08)))
	
	while(Priority_Event.size() > 0 && numbers_of_event > 0):
		var priority_key = Priority_Event.pop_front()
		for eachEvent in rawEvent:
			if eachEvent.has("Conditions"):
				if eachEvent["Conditions"][0] == "FOLLOW-UP" && eachEvent["Conditions"][1].has(priority_key):
					eventID.append(eachEvent["id"])
					numbers_of_event -= 1
	
	for i in numbers_of_event:
		_addNextEvent()

func _addNextEvent():
	var event_index_random = randi() % rawEvent.size()
	var event = rawEvent[event_index_random]
	if event["RandomTrue"] != true:
		_addNextEvent()
		return
	if event["Repeatable"] == false:
		if !alreadyTriggeredEvent.has(event["id"]):
			alreadyTriggeredEvent.append(event["id"])
		else:
			_addNextEvent()
			return
	eventID.append(event["id"])


func ActivateEvent():
	if eventID.front() == null:
		self.visible = false
		return
	eventReader.setEventID(eventID.pop_front())
	eventReader.processNextEvent()

func _removeAllEvent():
	eventID.clear()

#RETURNING METHODS
func getAllEventIDHierarchy():
	eventReader.setEventID(eventID)

func addFollowUpEvent(event):
	Priority_Event.append(event)
