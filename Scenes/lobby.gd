extends Control
var consPosition = [Vector2(279,242), Vector2(605,164),Vector2(1199,164),Vector2(1497,288)]
var positionRandom = []
var _button

func _ready() -> void:
	IngameStoredProcessSetting.crew_in_ship = ["Nashir","Fumiko"]
	setRandomPosition()

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
	pass


################################################# INTERACTION DIALOGUE

func set_initialDialogue():

	pass

func _on_maxim_button_down() -> void:
	DialogueManager.show_example_dialogue_balloon(maxim_initialDialogue, "interaction_maxim")
	pass # Replace with function body.


func _on_fumiko_button_down() -> void:
	DialogueManager.show_example_dialogue_balloon(maxim_initialDialogue, "interaction_fumiko")
	pass # Replace with function body.


func _on_regina_button_down() -> void:
	DialogueManager.show_example_dialogue_balloon(maxim_initialDialogue, "interaction_regina")
	pass # Replace with function body.


func _on_nashir_button_down() -> void:
	DialogueManager.show_example_dialogue_balloon(maxim_initialDialogue, "interaction_nashir")
	pass # Replace with function body.




################################################# EVENT DIALOGUE
var Tag = []
var resource = IngameStoredProcessSetting

func trigger_eventDialogue():	##TRIGGER EVENT
	pass

func get_eventDialogue():
	
	return

func setTag():
	Tag.clear()
	for a in resource.AlreadyTriggeredDialogueEvent:
		Tag.append(a)
	
	for a in resource.recent_events:
		Tag.append(a)
	
	if resource.Cycle == 1 or resource == 0:
		Tag.append("firstday")
	elif resource.Cycle == 50:
		Tag.append("fiftyday")
	elif resource.Cycle == 100:
		Tag.append("hundredday")
	
	Tag.append(resource.current_Factions)
	
	if resource.crew_in_ship.has("Regina") and resource._current_hunger["Regina"] < 0.3:
		Tag.append("regina_hunger")
	if resource.crew_in_ship.has("Maxim") and resource._current_hunger["Maxim"] < 0.3:
		Tag.append("maxim_hunger")
	if resource.crew_in_ship.has("Nashir") and resource._current_hunger["Nashir"] < 0.3:
		Tag.append("nashir_hunger")
	if resource.crew_in_ship.has("Fumiko") and resource._current_hunger["Fumiko"] < 0.3:
		Tag.append("fumiko_hunger")
	
	if resource.crew_in_ship.has("Regina") and resource._sanity["Regina"] < 0.3:
		Tag.append("regina_mad")
	if resource.crew_in_ship.has("Maxim") and resource._sanity["Maxim"] < 0.3:
		Tag.append("maxim_mad")
	if resource.crew_in_ship.has("Nashir") and resource._sanity["Nashir"] < 0.3:
		Tag.append("nashir_mad")
	if resource.crew_in_ship.has("Fumiko") and resource._sanity["Fumiko"] < 0.3:
		Tag.append("fumiko_mad")
	
	return

######################## VAR INTERACT DIALOGUE
var maxim_initialDialogue = load("res://DialogueSystem/EventDialogue/Dialogue_interact.dialogue")
