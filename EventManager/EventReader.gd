extends Node2D
var EventID = []
var event
var buttonCounts = 0
@onready var title = $Title
@onready var desc = $Description
@onready var button_container = $Button_Container


func _ready():
	var file_path = "res://Scripts/Events.json"
	if(FileAccess.file_exists(file_path)):
		var file = FileAccess.open(file_path,FileAccess.READ)
		var json_text = file.get_as_text()
		event = parse_json(json_text)
	else: 
		print("EVENT-READER-SCRIPT://  'func _ready()' : 'Failed to locate'")


func parse_json(json_text):
	var json = JSON.new()
	var result = json.parse(json_text)
	if result != OK:
		print("EVENT-READER-SCRIPT://  'parse_json' : 'Failed to analyze json file'", json.get_error_line())
		return []
	return json.get_data()


func setEventID(Event):
	EventID = int(Event)

func find_by_id(id):
	for entry in event:
		if entry["id"] == id:
			return entry

func processNextEvent():			#PLAY NEXT EVENT
	var CurrentID = EventID
	var currentEvent = find_by_id(CurrentID)
	var parent = get_parent()
	
	title.text = currentEvent["name"] 
	desc.text =  currentEvent["description"] 
	
	if currentEvent.has("FollowUp"):
		for follow_up_event in currentEvent["FollowUp"]:
			parent.addFollowUpEvent(follow_up_event)
	
	#HANDLE BUTTON FOR CHOICES
	HandleButton(currentEvent)
	#HANDLE CHANCES OR PROBABILITY
	if(currentEvent.has("Probability")):
		Probability(currentEvent)
	if(currentEvent.has("Command")):
		for command in currentEvent["Command"]:
			RunKeyWord(command)


func HandleButton(Event):
	var HasNoChoice = true
	var button_index = 1
	clear_container(button_container)
	while Event.has("Choice-"+str(button_index)):
		HasNoChoice = false
		var choice_data = Event["Choice-"+str(button_index)]
		_create_choice_button(choice_data, button_index)
		button_index += 1
	
	if HasNoChoice:
		_create_choice_button(["","","Okay"], 1)
		pass


func Probability(Event):
	var probability_list = Event["Probability"]
	var total_probability = 0
	for item in probability_list:
		total_probability += item[0]
	
	var random = randi() % int(total_probability)
	var Current_Sum = 0
	for item in probability_list:
		Current_Sum += item[0]
		if random < Current_Sum:
			for Command in item[1]:
				RunKeyWord(Command)


func RunKeyWord(Command):
	var global_resource = $"/root/GlobalResources"
	var _command = Command
	if _command.begins_with("@ADD_EFFECTS"):
		_command = _command.substr("@ADD_EFFECTS".length(), _command.length() - "@ADD_EFFECTS".length())
		_command.strip_edges()
		global_resource.addGameEffect(_command)
	elif _command.begins_with("@TITLE"):
		_command = _command.substr("@TITLE".length(), _command.length() - "@TITLE".length())
		_command.strip_edges()
		title.text = _command
	elif _command.begins_with("@DESCRIPTION"):
		_command = _command.substr("@DESCRIPTION".length(), _command.length() - "@DESCRIPTION".length())
		_command.strip_edges()
		desc.text = _command
	elif _command.begins_with("@RESET"):
		_command = _command.substr("@RESET".length(), _command.length() - "@RESET".length())
		_command.strip_edges()
		global_resource.reset(_command)
	else:
		print("Unable to identify Keyword in the context: '",_command,"'")



func clear_container(container: Control):
	for child in container.get_children():
		child.queue_free()

func _create_choice_button(choice_data, index):
	var button = Button.new()
	button.text = choice_data[2]
	button.connect("pressed", Callable(self, "_on_choice_button_pressed").bind(choice_data))
	button_container.add_child(button)

func _on_choice_button_pressed(choice_data):
	var Global_resources = $"/root/GlobalResources"
	var parent = get_parent()
	
	if choice_data[2] == "Okay":
		parent.ActivateEvent()
		return
	
	if _can_satisfy_choice(choice_data):
		if str (choice_data[0]) != "null":
			setEventID(choice_data[0])
			processNextEvent()
		else:
			parent._addNextEvent()
			processNextEvent()
	else:
		print("DEBUG: CONDITIONS NOT SATISFIED")
	pass


func _can_satisfy_choice(choice_data):
	var condition = false
	var Global_resources = $/root/GlobalResources
	var conditionResource = choice_data[1]
	if str(choice_data[1]) == "[<null>]":
		return true
	for item in choice_data[1]:
		match(item[0]):
			"spareparts":
				condition = item[1] < Global_resources.getSpareparts() 
				Global_resources.subtractItem(condition,"spareparts", item[1])
			"biogene":
				pass
		pass
	return condition #DEFAULT, ONLY FOR DEBUGGING PURPOSES 
