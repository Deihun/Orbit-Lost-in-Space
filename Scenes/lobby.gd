extends Control
var consPosition = [Vector2(279,242), Vector2(605,164),Vector2(1199,164),Vector2(1497,288)]
var positionRandom = []
var balloon 
var _button

func _ready() -> void:
	#IngameStoredProcessSetting.crew_in_ship = ["Maxim","Regina","Fumiko"]
	balloon = dialogueBalloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	setRandomPosition()
	initializeJSONFILE()
	setTag()
	

func setRandomPosition():
	positionRandom = consPosition.duplicate()
	positionRandom.shuffle()
	$Maxim.position = positionRandom.pop_front()
	$Fumiko.position = positionRandom.pop_front()
	$Regina.position = positionRandom.pop_front()
	$Nashir.position = positionRandom.pop_front()
	
	if IngameStoredProcessSetting.crew_in_ship.has("Regina") : $Regina.show()
	else: $Regina.hide()
	if IngameStoredProcessSetting.crew_in_ship.has("Maxim") : $Maxim.show()
	else: $Maxim.hide()
	if IngameStoredProcessSetting.crew_in_ship.has("Nashir") : $Nashir.show()
	else: $Nashir.hide()
	if IngameStoredProcessSetting.crew_in_ship.has("Fumiko") : $Fumiko.show()
	else: $Fumiko.hide()


################################################# INTERACTION DIALOGUE

func set_initialDialogue():
	setTag()
	var getDialogueTitle : String = _getRandomEvent()
	#print("CHOSEN DIALOGUE EVENT: ", getDialogueTitle)
	DialogueManager.show_dialogue_balloon(FirstDayDialogue, getDialogueTitle)



func _on_maxim_button_down() -> void:
	DialogueManager.show_dialogue_balloon(maxim_initialDialogue,"interaction_maxim")
	#balloon.start(maxim_initialDialogue, "interaction_maxim")
	pass # Replace with function body.


func _on_fumiko_button_down() -> void:
	DialogueManager.show_dialogue_balloon(maxim_initialDialogue, "interaction_fumiko")
	pass # Replace with function body.


func _on_regina_button_down() -> void:
	DialogueManager.show_dialogue_balloon(maxim_initialDialogue, "interaction_regina")
	pass # Replace with function body.


func _on_nashir_button_down() -> void:
	DialogueManager.show_dialogue_balloon(maxim_initialDialogue, "interaction_nashir")
	pass # Replace with function body.




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
