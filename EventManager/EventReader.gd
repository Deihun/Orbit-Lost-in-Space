extends Node2D
var EventID : int
var event
var buttonCounts = 0
var button_index = 1
var temp_choice_data = []
var description = ""


@onready var title = $Title
@onready var desc = $Description
@onready var button_container = $Container/Container_EventButton


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


func setEventID(Event : int):
	EventID = Event


func find_by_id(id):
	for entry in event:
		if entry["id"] == id:
			return entry


func processNextEvent():			#PLAY NEXT EVENT
	var CurrentID = EventID
	var currentEvent = find_by_id(CurrentID)
	var parent = get_parent()
	
	title.text = currentEvent["name"] 
	desc.text = currentEvent["description"] 
	description = currentEvent["description"]

	if currentEvent.has("FollowUp"):
		for follow_up_event in currentEvent["FollowUp"]:
			parent.addFollowUpEvent(follow_up_event)
	
	#HANDLE BUTTON FOR CHOICES
	HandleButton(currentEvent)
	#HANDLES HIDDEN CHOICE
	HiddenChoice(currentEvent)
	#HANDLE CHANCES OR PROBABILITY
	if(currentEvent.has("Probability")):
		Probability(currentEvent)
	if(currentEvent.has("Command")):
		for command in currentEvent["Command"]:
			RunKeyWord(command)


func HandleButton(Event):
	var HasNoChoice = true
	button_index = 1
	temp_choice_data = []
	clear_container(button_container)
	
	while Event.has("Choice-"+str(button_index)):
		HasNoChoice = false
		var choice_data = Event["Choice-"+str(button_index)]
		_create_choice_button(choice_data, button_index)
		button_index += 1
		temp_choice_data.append(choice_data)
	
	if HasNoChoice:
		_create_choice_button(["","","Okay"], 1)
		temp_choice_data.append(["","","Okay"])
		pass
	_reupdate_button()


func HiddenChoice(Event):
	var globalResources : GlobalResources = $"/root/GlobalResources"
	if Event.has("HiddenChoice"):
		var inner_array = Event["HiddenChoice"][0]
		var conditionArray = inner_array[0]
		var condition = Event["HiddenChoice"][0][0]
		
		print("Debug: // HAS = ", condition, " HAS_UNIQUE_ITEM = ", 0, Event["HiddenChoice"][0])
		print("Debug2: ",Event["HiddenChoice"][0][0][1][0],Event["HiddenChoice"][0][1][1])
		
		match(condition):
			"HAS":
				if globalResources.hasItem(Event["HiddenChoice"][0][1][0],Event["HiddenChoice"][0][1][1]):
					_create_choice_button(Event["HiddenChoice"][1], button_index)
					button_index += 1
					temp_choice_data.append(Event["HiddenChoice"][1])
			"HAS_UNIQUE_ITEM":
				if globalResources.uniqueItems.has(Event["HiddenChoice"][0][1][0]):
					_create_choice_button(Event["HiddenChoice"][1], button_index)
					button_index += 1
					temp_choice_data.append(Event["HiddenChoice"][1])
			"CREW":
				if IngameStoredProcessSetting.crew_in_ship.has(Event["HiddenChoice"][0][1][0]):
					_create_choice_button(Event["HiddenChoice"][1], button_index)
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
	var numbers = ["0","1","2","3","4","5","6","7","8","9","-","."]
	var global_resource = $"/root/GlobalResources"
	var _command : String = Command
	
	if _command.begins_with("@ADD_EFFECTS"):
		_command = _command.substr("@ADD_EFFECTS".length(), _command.length() - "@ADD_EFFECTS".length())
		_command.strip_edges()
		global_resource.addGameEffect(_command)
	elif _command.begins_with("@ADD_MATERIALS"):
		_command = _command.substr("@ADD_MATERIALS".length(), _command.length() - "@ADD_MATERIALS".length())
		_command.strip_edges()
		var item_name = ""
		var amount = 0
		for i in range(_command.length()):
			var char = _command[i]
			if numbers.has(char):
				item_name = _command.substr(0, i).strip_edges()  # Get the item name and strip edges.
				amount = int(_command.substr(i, _command.length() - i))  # Get the amount as an integer.
				break 
		GlobalResources.AddItem(true,item_name,amount)
	elif _command.begins_with("@RELATIONSHIP_INCREASE"):	#INCOMPLETE
		_command = _command.substr("@RELATIONSHIP_INCREASE".length(), _command.length() - "@RELATIONSHIP_INCREASE".length())
		_command.strip_edges()
		var crew_name = ""
		var value : float = 0.0
		for i in range (_command.length()):
			var char = _command[i]
			if numbers.has(char):
				crew_name = _command.substr(0,i)
				value = float(_command.substr(i, _command.length() - i))
		IngameStoredProcessSetting.addRelationshipBetweenCrew(crew_name,"JERRY",value)
	elif _command.begins_with("@SANITY_INCREASE"):	#INCOMPLETE
		_command = _command.substr("@SANITY_INCREASE".length(), _command.length() - "@SANITY_INCREASE".length())
		_command.strip_edges()
		var crew_name = ""
		var value : float = 0.0
		for i in range (_command.length()):
			var char = _command[i]
			if numbers.has(char):
				crew_name = _command.substr(0,i)
				value = float(_command.substr(i, _command.length() - i))
		IngameStoredProcessSetting.increaseDecreaseSanity(crew_name,value)
	elif _command.begins_with("@TITLE"):
		_command = _command.substr("@TITLE".length(), _command.length() - "@TITLE".length())
		_command.strip_edges()
		title.text = _command
	elif _command.begins_with("@ANOTHER_EVENT"):#Use ID for this case
		_command = _command.substr("@ANOTHER_EVENT".length(), _command.length() - "@ANOTHER_EVENT".length())
		_command.strip_edges()
		GlobalResources.eventID.append(int(_command))
	elif _command.begins_with("@DESCRIPTION"):
		_command = _command.substr("@DESCRIPTION".length(), _command.length() - "@DESCRIPTION".length())
		_command.strip_edges()
		desc.text = _command
	elif _command.begins_with("@RESET"):
		_command = _command.substr("@RESET".length(), _command.length() - "@RESET".length())
		_command.strip_edges()
		global_resource.reset(_command)
	elif _command.begins_with("@GAMEOVER"):
		_command = _command.substr("@GAMEOVER".length(), _command.length() - "@GAMEOVER".length())
		_command.strip_edges()
		var parent = get_parent().get_parent()
		parent.GameOver(_command)
	elif _command.begins_with("@CRITICAL"):
		_command = _command.substr("@CRITICAL".length(), _command.length() - "@CRITICAL".length())
		_command.strip_edges()
		GlobalResources.Critical_Event.append(_command)
	elif _command.begins_with("@ADD_PROBABILITY_FACTIONS"): #INCOMPLETE - NEED TO UPDATE WHEN FACTIONS(DOCUMENT) COMPLETE
		_command = _command.substr("@ADD_PROBABILITY_FACTIONS".length(), _command.length() - "@ADD_PROBABILITY_FACTIONS".length())
		_command.strip_edges()
		#IngameStoredProcessSetting.Factions_Probability
	elif _command.begins_with("@DO_RANDOMDAMAGE"): #INCOMPLETE - NEED TO UPDATE WHEN FACTIONS(DOCUMENT) COMPLETE
		_command = _command.substr("@DO_RANDOMDAMAGE".length(), _command.length() - "@DO_RANDOMDAMAGE".length())
		_command.strip_edges()
		IngameStoredProcessSetting.doRandomDamage(float(_command))
	elif _command.begins_with("@DO_DAMAGE"):
		_command = _command.substr("@DO_DAMAGE".length(), _command.length() - "@DO_DAMAGE".length())
		_command.strip_edges()
		var crew_name = ""
		var amount : float = 0.0
		for i in range(_command.length()):
			var char = _command[i]
			if numbers.has(char):
				crew_name = _command.substr(0, i).strip_edges()  # Get the item name and strip edges.
				amount = int(_command.substr(i, _command.length() - i))  # Get the amount as an integer.
				break 
		IngameStoredProcessSetting.doDamageToSpecific(crew_name,amount)
	elif _command.begins_with("@YES_TO_LANDING"): #INCOMPLETE - NEED TO UPDATE WHEN FACTIONS(DOCUMENT) COMPLETE
		IngameStoredProcessSetting._yes_in_faction()
	elif _command.begins_with("@NO_TO_LANDING"): #INCOMPLETE - NEED TO UPDATE WHEN FACTIONS(DOCUMENT) COMPLETE
		IngameStoredProcessSetting._no_in_faction()
	elif _command.begins_with("@FACTS"): #INCOMPLETE - NEED TO UPDATE WHEN FACTIONS(DOCUMENT) COMPLETE
		_command = _command.substr("@FACTS".length(), _command.length() - "@FACTS".length())
		_command.strip_edges()
		_command.replace(" ","")
		var factChecks = NodeFinder.find_node_by_name(get_tree().current_scene,"FactButton")
		if factChecks:
			print("Facts adding ", _command)
			factChecks.set_fact_encountered(_command)
			return
			if factChecks.rawFacts["facts"].find({"id": _command}) :
				factChecks.set_fact_encountered(_command)
			else:
				print(_command, " - Fact doesnt exist")
		else:
			print("Error// Cant find FactGroup node on current scene")
	else:
		print("Unable to identify Keyword in the context: '",_command,"'")


func clear_container(container: VBoxContainer):
	for i in range(container.get_child_count() - 1, -1, -1):
		var child = container.get_child(i)
		child.queue_free()


func _create_choice_button(choice_data, index):
	var button = Button.new() #CREATE AND HANDLES BUTTON
	print(choice_data)
	button.text = translate_description_to_gettedProcess(choice_data[2])
	button.z_index = 1 
	button.modulate.a = 1.0
	button.custom_minimum_size = Vector2(300,250)
	button.show()
	button_container.add_child(button)
	#button.size_flags_vertical = Control.SIZE_FILL
	#var un_touch_label = preload("res://UnTouch_Label/UnTouchLabel.tscn").instantiate() 
	#await get_tree().create_timer(0.3).timeout
	#un_touch_label.updateText(translate_description_to_gettedProcess(choice_data[2]))  # Update the label text in UnTouchLabel
	#un_touch_label.z_index = 0
	#button.size = un_touch_label.getNinePatchRectSize()
	#un_touch_label.size = un_touch_label.getNinePatchRectSize()
	#un_touch_label.update_nine_patch_rect_size()
	
	#button_container.add_child(un_touch_label) 
	#un_touch_label.add_child(button)
	button.connect("pressed", Callable(self, "_on_choice_button_pressed").bind(choice_data))
	button.mouse_filter = Control.MOUSE_FILTER_PASS
	#var current_position = Vector2(0, (index - 1) * (un_touch_label.size.y + 10))
	#un_touch_label.position = current_position

func translate_description_to_gettedProcess(text):
	var global_var = $"/root/GlobalResources"
	var value = text
	if "@SPAREPARTS()" in text:
		value = text.replace("@SPAREPARTS()", str(global_var.spareparts))
	elif "@FOOD()" in text:
		value = text.replace("@FOOD()", str(global_var.ration))
	elif "@BIOGENE()" in text:
		value = text.replace("@BIOGENE()", str(global_var.biogene))
	elif "@DUCTAPE()" in text:
		value = text.replace("@DUCTAPE()", str(global_var.ductape))
	elif "@FUEL()" in text: 
		value = text.replace("@FUEL()", str(global_var.fuel))
	elif "@OXYGEN()" in text:
		value = text.replace("@OXYGEN()", str(global_var.oxygen))
	elif "@MEDKIT()" in text:
		value = text.replace("@MEDKIT()", str(global_var.medicine))
	return value

func _on_choice_button_pressed(choice_data):
	var Global_resources = $"/root/GlobalResources"
	var parent = get_parent()
	
	if choice_data[2] == "Okay":
		GlobalResources.currentActiveQueue -= 1
		clear_container(button_container)
		parent.ActivateEvent()
		return
	
	if _can_satisfy_choice(choice_data):
		if !str(choice_data[1]).contains("<null>"):
			for item in choice_data[1]:
				Global_resources.subtractItem(true,item[0],item[1])
				pass
			
			setEventID(choice_data[0])
			processNextEvent()
			
		else:
			setEventID(choice_data[0])
			processNextEvent()
		$".."._triggerDialogue(description, $"..".isTextToSpeechOn)
	else:
		print("DEBUG: CONDITIONS NOT SATISFIED")
	pass


func _can_satisfy_choice(choice_data):
	var condition = true
	var Global_resources = $/root/GlobalResources
	var conditionResource = choice_data[1]
	if str(choice_data[1]).contains("<null>") :
		return true
	for item in choice_data[1]:
		var condition1 = Global_resources.hasItem(item[0],item[1])
		condition = condition1 != false
	return condition #DEFAULT, ONLY FOR DEBUGGING PURPOSES 


func _reupdate_button():
	clear_container(button_container)
	var index = 1
	if temp_choice_data == null:
		return
	for data in temp_choice_data:
		_create_choice_button(data, index)
		index += 1
	pass
