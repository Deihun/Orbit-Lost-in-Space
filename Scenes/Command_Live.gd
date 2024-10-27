extends Panel
var canOpenCommand : bool = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Confirm") and $".".visible == true:
		$".".hide()
		command(str($_Command.text).to_upper()) 
		
	if Input.is_action_just_pressed("openCommand") and canOpenCommand:
		canOpenCommand = false
		$CommandCooldown.start()
		$".".visible = !$".".visible


func _on_command_cooldown_timeout() -> void:
	canOpenCommand = true

func command(_command : String):
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
		#IngameStoredProcessSetting.Factions_Probability
	else:
		print("'", _command ,"' is not recognize as a command")
	
