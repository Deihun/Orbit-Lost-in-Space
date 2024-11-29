extends Node2D

func addData(data : int, _bool : bool):
	match(data):
		1:
			SettingsDataContainer.tutorialPanel_1 = _bool
		2:
			SettingsDataContainer.tutorialPanel_2 = _bool
		3:
			SettingsDataContainer.tutorialPanel_3 = _bool
		4:
			SettingsDataContainer.tutorialPanel_4 = _bool
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())


func _on_child_exiting_tree(node: Node) -> void:
	var a 
	match node.name:
		"TutorialPanel":
			a = {
				"label" : "Inside the Shuttle\n\nWelcome to the Shuttle. Navigate the shuttle by using each arrow at the bottom corners.",
				"title" : "Inside the Shuttle",
				"texture": "res://TutorialUI/lobby.png"
			}
		"TutorialPanel2":
			a = {
				"label" : "Encountering Events\n\nWelcome to the cockpit. The screen will display events that happens to your ship and crew. You will be presented with different choices that either consumes or gives resources.",
				"title" : "Encountering Events",
				"texture": "res://TutorialUI/Events.png"
			}
		"TutorialPanel3":
			a = {
				"label" : "Crafting Resources\n\nWelcome to the Crafting room. You can craft different kinds of resources using fuel and other materials. It takes 1 cycle to finish the crafting process.",
				"title" : "Crafting Resources",
				"texture": "res://TutorialUI/Crafting.png"
			}
		"TutorialPanel4":
			a = {
				"label" : "Ending Cycles\n\nAfter finishing the event, you may end the cycle by clicking the EndCycle Button at the top left of your screen. After ending the cycle, a set amount of resource is consumed and random events may happen to you and your crew.",
				"title" : "Ending Cycles",
				"texture": "res://TutorialUI/EndCycle.png"
			}
			var b = {
				"label" : "Main Objective\n\nYour main goal is to reach 70+ cycles to arrive at your new home with the rest of the survivors.",
				"title" : "Main Objective",
				"texture": "res://TutorialUI/Tutorial.png"
			}
			IngameStoredProcessSetting._stored_guide.append(b.duplicate())
	IngameStoredProcessSetting._stored_guide.append(a.duplicate())
	IngameStoredProcessSetting._stored_guide = make_unique(IngameStoredProcessSetting._stored_guide).duplicate()

func make_unique(array : Array) -> Array:
	var seen = {}
	var result = []
	for value in array:
		if not seen.has(value):
			seen[value] = true
			result.append(value)
	return result
