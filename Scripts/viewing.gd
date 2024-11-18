extends Control


func updateViewer(wholeEvent):
	for child in $ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
	
	for event in wholeEvent:
		var child = preload("res://Scripts/events.tscn").instantiate()
		child.addTitleAndDescription(event["name"],event["description"], event["id"])
		child.isRandom_IsActive(event["Repeatable"],event["RandomTrue"])
		command(event,child)
		_choice(event, child)
		_hiddenChoice(event, child)
		_condition(event, child)
		probability(event,child)
		$ScrollContainer/VBoxContainer.add_child(child)

func command(event, child):
	if !event.has("Command") : return
	for _command in event["Command"]:
		child.addPreviewCommand(_command)

func _condition(event, child):
	if !event.has("Conditions"): return
	child.addConditionView(str(event["Conditions"]))

func _choice(_event, child):
	var choice_count = 1
	for key in _event.keys():
		if key.begins_with("Choice-"):
			var choice_data = _event[key]
			child.addChoiceButton(choice_data)
			choice_count += 1

func _hiddenChoice(_event, child):
	if !_event.has("HiddenChoice"): return
	child.hiddenChoice(_event["HiddenChoice"])

func probability(_event, child):
	if !_event.has("Probability"): return
	child.probability(_event["Probability"])
