extends Panel
var canOpenCommand : bool = true
var command_history : String = ""


func _input(event: InputEvent) -> void:
	if $"../../PauseMenu".visible: return
	if Input.is_action_just_pressed("Confirm") and $".".visible == true and $_Command.text != "" or null:
		command(str($_Command.text)) 
		$_Command.text = ""
		Engine.time_scale = 1.0 if !$".".visible else 0.0
		$"..".canBeClick = !($".".visible)
	elif Input.is_action_just_pressed("Confirm") and $".".visible == true and $_Command.text == "" or null:
		$".".hide()
		Engine.time_scale = 1.0 if !$".".visible else 0.0
		$"..".canBeClick = !($".".visible)
	elif Input.is_action_just_pressed("openCommand") and canOpenCommand:
		$".".visible = !$".".visible
		$_Command.grab_focus()
		$CommandCooldown.start()
		canOpenCommand = false
		Engine.time_scale = 1.0 if !$".".visible else 0.0
		$"..".canBeClick = !($".".visible)


func _on_command_cooldown_timeout() -> void:
	canOpenCommand = true


func command(_command : String):
	var commandMessage = _command
	addHistory(_command)
	_command = _command.to_upper()
	var numbers = ["0","1","2","3","4","5","6","7","8","9","-","."]
	var global_resource = GlobalResources
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
		pass
	elif _command.begins_with("@ANOTHER_EVENT"):#Use ID for this case
		_command = _command.substr("@ANOTHER_EVENT".length(), _command.length() - "@ANOTHER_EVENT".length())
		_command.strip_edges()
		GlobalResources.eventID.append(int(_command))
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
	elif _command.begins_with("@CYCLE"): #INCOMPLETE - NEED TO UPDATE WHEN FACTIONS(DOCUMENT) COMPLETE
		_command = _command.substr("@CYCLE".length(), _command.length() - "@CYCLE".length())
		_command.strip_edges()
		IngameStoredProcessSetting.Cycle = int(_command)
		$"../..".updateUI()
	elif _command.begins_with("@PROBABILITY_FACTION"): #INCOMPLETE - NEED TO UPDATE WHEN FACTIONS(DOCUMENT) COMPLETE
		_command = _command.substr("@PROBABILITY_FACTION".length(), _command.length() - "@PROBABILITY_FACTION".length())
		_command.strip_edges()
		IngameStoredProcessSetting.TotalProbabilityForFactionsToFound = float(_command)
		$"../..".updateUI()
	elif _command.begins_with("@TRIGGER_EVENT"): 
		var a : int
		_command = _command.substr("@TRIGGER_EVENT".length(), _command.length() - "@TRIGGER_EVENT".length())
		if !_command.strip_edges().is_valid_int(): 
			addHistory("/ERROR//: Cannot convert String to int '" + _command+"'")
		elif $"../../EventHandler"._is_in_event_index(a): addHistory("/ERROR//: '" + _command+"' ID does not exist in context of list of events")
		else:
			a = int(_command)
			GlobalResources.eventID.append(a)
			$"../../EventHandler".ActivateEvent()
			if $"../../EventHandler/EventUIAnimation".visible == false:
				$"../../EventHandler".switchIt(true)
	elif _command.begins_with("@HELP"): 
		var help = "//Entering Help Command//\n
		@CRITICAL - add critical events\n
		@ADD_EFFECTS - add effects of a game that affects events\n
		@ADD_MATERIALS - Add resources materials \n
		@ADD_UNIQUE_MATERIALS - add 1 unique material \n
		@RELATIONSHIP_INCREASE - Increase relationship of a specific character in range of 0.0 - 1.0\n
		@ADD_ANOTHER_EVENT - Add event on queue\n
		@RESET - set the specified materials into zero\n
		@GAMEOVER - trigger an game over and trigger an end scene base on selected game over
		"
		addHistory(help)
	elif _command.begins_with("@ADD_CREW"): 
		_command = _command.substr("@ADD_CREW".length(), _command.length() - "@ADD_CREW".length())
		_command.capitalize()
		IngameStoredProcessSetting.crew_in_ship.append(_command)
	elif _command.begins_with("@DELETE_CREW"):
		_command = _command.substr("@DELETE_CREW".length(), _command.length() - "@DELETE_CREW".length())
		_command.capitalize()
		if IngameStoredProcessSetting.crew_in_ship.has(_command):IngameStoredProcessSetting.crew_in_ship.erase(_command)
		else: addHistory("/ERROR//: Cannot convert String to int '" + _command+"'")
	elif _command.begins_with("@SET_FACTION"):
		commandMessage = commandMessage.substr("@SET_FACTION".length(), commandMessage.length() - "@SET_FACTION".length())
		IngameStoredProcessSetting.current_Factions = commandMessage
	else:
		commandMessage = "Unrecognize command: '" + commandMessage + "'"
		addHistory(commandMessage)
	$"../..".updateCockpit()
	$"../..".updateUI()

func addHistory(message : String):
	command_history += message + "\n"
	$ScrollContainer/RecentCode.text = command_history
	$_Command.text = ""
