extends Control
@onready var crew1 : Button = $Crew_1
@onready var crew2 : Button = $Crew_2
@onready var crew3 : Button = $Crew_3
@onready var crew4 : Button = $Crew_4

var consPosition = [Vector2(321,348), Vector2(669,240),Vector2(1007,243),Vector2(1201,332)]
var atBack = [Vector2(669,240),Vector2(1007,243)]
var button_array = []
var crew = []
var getcrew = []
var positionRandom = []
var balloon 
var _button

func _ready() -> void:
	button_array = [crew1,crew2,crew3,crew4]
	#IngameStoredProcessSetting.crew_in_ship = ["Maxim","Fumiko","Nashir"]
	getcrew = IngameStoredProcessSetting.crew_in_ship.duplicate()
	balloon = dialogueBalloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	setRandomPosition()
	initializeJSONFILE()
	setTag()
	

func setRandomPosition():
	getcrew = IngameStoredProcessSetting.crew_in_ship.duplicate()
	positionRandom = consPosition.duplicate()
	positionRandom.shuffle()
	$Crew_1.position = positionRandom.pop_front()
	$Crew_2.position = positionRandom.pop_front()
	$Crew_3.position = positionRandom.pop_front()
	$Crew_4.position = positionRandom.pop_front()

	var pos_big = Vector2(80,750)
	var pos_small = Vector2(80,800)
	var bigSize = Vector2(0.5,0.5)
	var smallSize = Vector2(0.37, 0.37)
	if getcrew.size() < 1: return
	for i in range(button_array.size()):
		var crew_member = getcrew[i] if i < getcrew.size() else null
		button_array[i].visible = crew_member != null
	for child in $Crew_1.get_children():
		child.queue_free()
	var resource = getScene(getcrew[0])
	resource = resource.instantiate()
	resource.scale = smallSize if atBack.has($Crew_1.position) else bigSize
	resource.position = pos_big + resource.position  if atBack.has($Crew_1) else pos_small + resource.position
	resource.scale.x *=  1 if randf() < 0.5 else -1
	$Crew_1.add_child(resource)

	if getcrew.size() < 2: return
	for child in $Crew_2.get_children():
		child.queue_free()
	var resource_2 = getScene(getcrew[1])
	resource_2 = resource_2.instantiate()
	resource_2.scale = smallSize if atBack.has($Crew_2.position) else bigSize
	resource_2.position = pos_big + resource_2.position  if atBack.has($Crew_2.position) else pos_small + resource_2.position
	resource_2.scale.x *=  1 if randf() < 0.5 else -1
	$Crew_2.add_child(resource_2)

	if getcrew.size() < 3: return
	for child in $Crew_3.get_children():
		child.queue_free()
	var resource_3 = getScene(getcrew[2])
	resource_3 = resource_3.instantiate()
	resource_3.scale = smallSize if atBack.has($Crew_3.position) else bigSize
	resource_3.position = pos_big + resource_3.position if atBack.has($Crew_3.position) else pos_small + resource_3.position
	resource_3.scale.x *=  1 if randf() < 0.5 else -1
	$Crew_3.add_child(resource_3)

	if getcrew.size() < 4: return
	for child in $Crew_4.get_children():
		child.queue_free()
	var resource_4 = getScene(getcrew[3])
	resource_4 = resource_4.instantiate()
	resource_4.scale = smallSize if atBack.has($Crew_4.position) else bigSize
	resource_4.position = pos_big + resource_4.position  if atBack.has($Crew_4.position) else pos_small + resource_4.position
	resource_4.scale.x *=  1 if randf() < 0.5 else -1
	$Crew_4.add_child(resource_4)

################################################# INTERACTION DIALOGUE
func assignCrew():
	crew = IngameStoredProcessSetting.crew_in_ship.duplicate()

func set_initialDialogue():
	setTag()
	var getDialogueTitle : String = _getRandomEvent()
	#print("CHOSEN DIALOGUE EVENT: ", getDialogueTitle)
	if getDialogueTitle != null and getDialogueTitle != "null":
		DialogueManager.show_dialogue_balloon(FirstDayDialogue, getDialogueTitle)



func _on_maxim_button_down() -> void: #CREW 0
	if getcrew.size() < 1: return
	var a = _getInteractionDialogue(getcrew[0])
	$Crew_1.add_child(resource)
	if a == null: return
	DialogueManager.show_dialogue_balloon(maxim_initialDialogue,a)


func _on_fumiko_button_down() -> void: #CREW 1
	if getcrew.size() < 2: return
	var a = _getInteractionDialogue(getcrew[1])
	if a == null: return
	DialogueManager.show_dialogue_balloon(maxim_initialDialogue, a)



func _on_regina_button_down() -> void: #CREW 2
	if getcrew.size() < 3: return
	var a = _getInteractionDialogue(getcrew[2])
	if a == null: return
	DialogueManager.show_dialogue_balloon(maxim_initialDialogue, a)



func _on_nashir_button_down() -> void: #CREW 3
	if getcrew.size() < 4: return
	var a = _getInteractionDialogue(getcrew[3])
	if a == null: return
	DialogueManager.show_dialogue_balloon(maxim_initialDialogue, a)


func getScene(crew_name : String):
	var resource
	match crew_name:
		"Maxim":
			resource = preload("res://Resources/CREW/CrewLobby/Maxim.tscn")
		"Fumiko":
			resource = preload("res://Resources/CREW/CrewLobby/Fumiko.tscn")
		"Regina":
			resource = preload("res://Resources/CREW/CrewLobby/Regina.tscn")
		"Nashir":
			resource = preload("res://Resources/CREW/CrewLobby/Nashir.tscn")
		"Jerry":
			resource = preload("res://Resources/CREW/CrewLobby/Jerry.tscn")
	print("Resource tag name: ", crew_name)
	return resource


func _getInteractionDialogue(value : String):
	match value:
		"Maxim":
			return "interaction_maxim"
		"Fumiko":
			return "interaction_fumiko" 
		"Regina":
			return "interaction_regina"
		"Nashir":
			return "interaction_nashir"
		_:
			return null


################################################# EVENT DIALOGUE
var recursion_check = 0
var Tag = []
var JSON_file
var json_path = "res://DialogueSystem/EventDialouge_data.json"
var resource = IngameStoredProcessSetting

func initializeJSONFILE():
	if(FileAccess.file_exists(json_path)):
		var file = FileAccess.open(json_path,FileAccess.READ)
		var json_text = file.get_as_text()
		JSON_file = parse_json(json_text)
	else: 
		print("EVENT-DIALOGUE-SCRIPT://  : 'Failed to locate'")

func parse_json(json_text):
	var json = JSON.new()
	var result = json.parse(json_text)
	if result != OK:
		print("EVENT-HANDLER-SCRIPT://  'parse_json' : 'Failed to analyze json file'", json.get_error_line())
		return []
	return json.get_data()


func _getRandomEvent() -> String:
	recursion_check += 1
	var event_index_random = randi() % JSON_file.size()
	var event = JSON_file[event_index_random]
	if Tag.has("FIRSTDAY"):
		if !event["TAG"].has("FIRSTDAY"):
			return _getRandomEvent()
	#print(str(event["TAG"]), Tag ,_random(event))
	if recursion_check > 900:
		recursion_check = 0
		return "null"
	if _random(event):
		var a : String = str(event["Name"])
		return a
	else:
		return _getRandomEvent()


func _random(event):
	var condition = true
	for tag in event["TAG"]:
		if Tag.has(tag):
			continue
		else:
			condition = false
			break
	return condition
	


func get_eventDialogue():
	
	return

func initialEvent():
	if IngameStoredProcessSetting.crew_in_ship.has("Maxim") and IngameStoredProcessSetting.crew_in_ship.has("Regina") and IngameStoredProcessSetting.crew_in_ship.has("Fumiko"):
		pass
	elif IngameStoredProcessSetting.crew_in_ship.has("Maxim") and IngameStoredProcessSetting.crew_in_ship.has("Fumiko") and IngameStoredProcessSetting.crew_in_ship.has("Nashir"):
		pass
	elif IngameStoredProcessSetting.crew_in_ship.has("Fumiko") and IngameStoredProcessSetting.crew_in_ship.has("Regina") and IngameStoredProcessSetting.crew_in_ship.has("Nashir"):
		pass
	elif IngameStoredProcessSetting.crew_in_ship.has("Nashir") and IngameStoredProcessSetting.crew_in_ship.has("Regina") and IngameStoredProcessSetting.crew_in_ship.has("Fumiko"):
		pass

func setTag():
	Tag.clear()
	Tag.append("")
	
	for a in resource.AlreadyTriggeredDialogueEvent:
		Tag.append(a)
	
	for a in resource.recent_events:
		Tag.append(a)
	
	for crew in resource.crew_in_ship:
		Tag.append(crew)
	
	if resource.Cycle == 1 or resource.Cycle == 0:
		Tag.append("FIRSTDAY")
	elif resource.Cycle == 50:
		Tag.append("FIFTHDAY")
	elif resource.Cycle == 100:
		Tag.append("HUNDREDDAY")
	
	Tag.append(resource.current_Factions)
	
	if resource.crew_in_ship.has("Regina") and resource._current_hunger["Regina"] < 0.15:
		Tag.append("regina_hunger")
	if resource.crew_in_ship.has("Maxim") and resource._current_hunger["Maxim"] < 0.15:
		Tag.append("maxim_hunger")
	if resource.crew_in_ship.has("Nashir") and resource._current_hunger["Nashir"] < 0.15:
		Tag.append("nashir_hunger")
	if resource.crew_in_ship.has("Fumiko") and resource._current_hunger["Fumiko"] < 0.15:
		Tag.append("fumiko_hunger")

	if resource.crew_in_ship.has("Regina") and resource._sanity["Regina"] > 0.25 and resource._sanity["Regina"] < 0.5:
		Tag.append("regina_sanity_low")
	if resource.crew_in_ship.has("Maxim") and resource._sanity["Maxim"] > 0.25 and resource._sanity["Maxim"] < 0.5:
		Tag.append("maxim_sanity_low")
	if resource.crew_in_ship.has("Nashir") and resource._sanity["Nashir"] > 0.25 and resource._sanity["Nashir"] < 0.5:
		Tag.append("nashir_sanity_low")
	if resource.crew_in_ship.has("Fumiko") and resource._sanity["Fumiko"] > 0.25 and resource._sanity["Fumiko"] < 0.5:
		Tag.append("fumiko_sanity_low")

	if resource.crew_in_ship.has("Regina") and resource._sanity["Regina"] < 0.25:
		Tag.append("regina_sanity_insane")
	if resource.crew_in_ship.has("Maxim") and resource._sanity["Maxim"] < 0.25:
		Tag.append("maxim_sanity_insane")
	if resource.crew_in_ship.has("Nashir") and resource._sanity["Nashir"] < 0.25:
		Tag.append("nashir_sanity_insane")
	if resource.crew_in_ship.has("Fumiko") and resource._sanity["Fumiko"] < 0.25:
		Tag.append("fumiko_sanity_insane")

	if resource.crew_in_ship.has("Regina") and resource._sanity["Regina"] > 0.85:
		Tag.append("regina_sanity_good")
	if resource.crew_in_ship.has("Maxim") and resource._sanity["Maxim"] > 0.85:
		Tag.append("maxim_sanity_good")
	if resource.crew_in_ship.has("Nashir") and resource._sanity["Nashir"] > 0.85:
		Tag.append("nashir_sanity_good")
	if resource.crew_in_ship.has("Fumiko") and resource._sanity["Fumiko"] > 0.85:
		Tag.append("fumiko_sanity_good")

	if resource.crew_in_ship.has("Regina") and resource._sanity["Regina"] < 0.3:
		Tag.append("regina_mad")
	if resource.crew_in_ship.has("Maxim") and resource._sanity["Maxim"] < 0.3:
		Tag.append("maxim_mad")
	if resource.crew_in_ship.has("Nashir") and resource._sanity["Nashir"] < 0.3:
		Tag.append("nashir_mad")
	if resource.crew_in_ship.has("Fumiko") and resource._sanity["Fumiko"] < 0.3:
		Tag.append("fumiko_mad")
	
	if resource._MaximRelationship["Regina"] < 0.25 and resource.crew_in_ship.has("Maxim"):
		Tag.append("maxin_hate_regina")
	if resource._relationship["Maxim"] < 0.25 and resource.crew_in_ship.has("Maxim"):
		Tag.append("maxin_hate_jerry")
	if resource._MaximRelationship["Fumiko"] < 0.25 and resource.crew_in_ship.has("Maxim"):
		Tag.append("maxin_hate_fumiko")
	if resource._MaximRelationship["Nashir"] < 0.25 and resource.crew_in_ship.has("Maxim"):
		Tag.append("maxin_hate_nashir")

	if resource._FumikoRelationship["Regina"] < 0.25 and resource.crew_in_ship.has("Fumiko"):
		Tag.append("fumiko_hate_regina")
	if resource._relationship["Fumiko"] < 0.25 and resource.crew_in_ship.has("Fumiko"):
		Tag.append("fumiko_hate_jerry")
	if resource._FumikoRelationship["Maxim"] < 0.25 and resource.crew_in_ship.has("Fumiko"):
		Tag.append("fumiko_hate_maxim")
	if resource._FumikoRelationship["Nashir"] < 0.25 and resource.crew_in_ship.has("Fumiko"):
		Tag.append("fumiko_hate_nashir")

	if resource._reginaRelationship["Fumiko"] < 0.25 and resource.crew_in_ship.has("Regina"):
		Tag.append("regina_hate_fumiko")
	if resource._relationship["Regina"] < 0.25 and resource.crew_in_ship.has("Regina"):
		Tag.append("regina_hate_jerry")
	if resource._reginaRelationship["Maxim"] < 0.25 and resource.crew_in_ship.has("Regina"):
		Tag.append("regina_hate_fumiko")
	if resource._reginaRelationship["Nashir"] < 0.25 and resource.crew_in_ship.has("Regina"):
		Tag.append("regina_hate_nashir")

	if resource._NashirRelationship["Regina"] < 0.25 and resource.crew_in_ship.has("Nashir"):
		Tag.append("naashir_hate_regina")
	if resource._relationship["Nashir"] < 0.25 and resource.crew_in_ship.has("Nashir"):
		Tag.append("naashir_hate_jerry")
	if resource._NashirRelationship["Maxim"] < 0.25 and resource.crew_in_ship.has("Nashir"):
		Tag.append("naashir_hate_maxim")
	if resource._NashirRelationship["Fumiko"] < 0.25 and resource.crew_in_ship.has("Nashir"):
		Tag.append("naashir_hate_fumiko")

	if resource._relationship["Regina"] < 0.22 and resource._relationship["Fumiko"] < 0.22 and resource._relationship["Maxim"] < 0.22 and resource._relationship["Nashir"] < 0.22:
		Tag.append("everyone_hate_jerry")
	return

######################## VAR INTERACT DIALOGUE
var dialogueBalloon = preload("res://DialogueSystem/DialogueBalloon/balloon.tscn")
var maxim_initialDialogue = load("res://DialogueSystem/EventDialogue/Dialogue_interact.dialogue")
var FirstDayDialogue = load("res://DialogueSystem/EventDialogue/FirstDay_Dialogue.dialogue")
