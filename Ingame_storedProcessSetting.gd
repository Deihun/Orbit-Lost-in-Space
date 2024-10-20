extends Node



#VARIABLE 
var Cycle = 0
var Scenes : String= ""


func newGame():
	Cycle = 1


func endCycle():
	_recent_events_adjust()
	Cycle += 1
	move_space()
	doDisease()
	doHealthChecker()
	doHunger()
	doOxygen()
	resetPerDay()
	
	#DELETE THIS LATER
	var a = str("Crew_in_ship:",crew_in_ship,"\nHunger:",_current_hunger,"\nHealth:",_health,"\nSanity:",_sanity,"\nDisease:",_disease)
	print(a)


func getCycle():
	return Cycle


#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#HANDLING FACTIONS
var current_Factions : String = "None"
var TravelPerSections : int = 1
var Target_factions : String = "None"
var TotalProbabilityForFactionsToFound : float = 0.0
var Factions_Probability = {
	"Faction1" : 0.0,
	"Faction2" : 0.0,
	"Faction3" : 0.0,
	"Faction4" : 0.0,
	"Faction5" : 0.0
}
var SubFactions_Probability = {
	"Asteroid" : 0.15,
	"Blackhole" : 0.01,
	"AbandonShip" : 0.3,
	"SmallPlanetoid" : 0.05,
	"UnnameFactions" : 0.0
}


func move_space(move_number : int = 1): #INCOMPLETE
	TravelPerSections += move_number
	print("Space Move: ",TravelPerSections)
	if TravelPerSections == 3:
		Target_factions = set_Factions()
		print("FACTIONS: ",Target_factions)
		current_Factions = Target_factions
		TravelPerSections = 1
	
	if Factions_Probability.keys().has(current_Factions):
		addFactionsCriticalEvent()
	elif SubFactions_Probability.keys().has(current_Factions):
		addFactionsCriticalEvent()


func set_Factions():
	if TotalProbabilityForFactionsToFound > (randf() *1.0):
		var total_FactionPicker_probability : float = 0.0
		for probability in Factions_Probability.values():
			total_FactionPicker_probability += probability
		var random_pick = randf() * total_FactionPicker_probability
		var cumulative_probability = 0.0
		for faction in Factions_Probability.keys():
			cumulative_probability += Factions_Probability[faction]
			if random_pick < cumulative_probability:
				return faction
		TotalProbabilityForFactionsToFound -= 0.025
	elif 0.25 > (randf() * 1.0):
		var total_FactionPicker_probability : float = 0.0
		for probability in SubFactions_Probability.values():
			total_FactionPicker_probability += probability
		var random_pick = randf() * total_FactionPicker_probability
		var cumulative_probability = 0.0
		for faction in SubFactions_Probability.keys():
			cumulative_probability += SubFactions_Probability[faction]
			if random_pick < cumulative_probability:
				return faction
		TotalProbabilityForFactionsToFound += 0.05
	else:
		TotalProbabilityForFactionsToFound += 0.1
		return "None"
	return "None"


func addFactionsCriticalEvent():#INCOMPLETE - MISSING MATCH TYPE CONDITION AND THE LIST OF CRITICAL EVENTS NEEDS
	var eventHandler = NodeFinder.find_node_by_name(get_tree().current_scene,"EventHandler")
	if eventHandler:#INCOMPLETE, HAS NO CONTENT
		#eventHandler.Critical_Event.append("TestingScene") 
		pass
	else:
		print("//ERROR - Can't find node name EventHandler")
	pass


func addSubFactionsCriticalEvent():#INCOMPLETE - MISSING MATCH TYPE CONDITION AND THE LIST OF CRITICAL EVENTS NEEDS
	var eventHandler = NodeFinder.find_node_by_name(get_tree().current_scene,"EventHandler")
	if eventHandler:
		eventHandler.Critical_Event.append() 
	else:
		print("//ERROR - Can't find node name EventHandler")
	pass


#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#								HANDLING REPORT_CYCLES
var Cycle_ReportList = [] #FirstDimesion = TextContent, #SecondDimension = Image
var recent_events = [] # Such as crew deaths something like that

func addOnCycleReportList(report : String):
	var split = report.split(" ")
	var name = split[0]
	var value = split[1]
	var index : int = 0
	if report.contains("has gone missing..."):
		name = report
		value = ""
	for each in Cycle_ReportList:
		if each[0] == name:
			break
		else:
			index += 1
	if Cycle_ReportList.size() > 0 and value != "":
		if Cycle_ReportList[0].has(name):
			Cycle_ReportList[index][1] += int(value)
		else:
			Cycle_ReportList.append([name, int(value)])
	elif Cycle_ReportList.size() > 0 and value == "":
		Cycle_ReportList.append([name, null])
	else:
		Cycle_ReportList.append([name, int(value)])
	pass

func _recent_events_adjust():
	var adjusting_recentEvent = []
	if recent_events.has("DEATH"): adjusting_recentEvent.append("2DAYDEATH")
	if recent_events.has("2DAYDEATH"): adjusting_recentEvent.append("3DAYDEATH")
	recent_events.clear()
	recent_events = adjusting_recentEvent.duplicate()
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#								CREW
var crew_in_ship = []


var _relationship = { #SAVE
	"Regina" : 0.5,
	"Maxim"  : 0.5,
	"Nashir" : 0.5,
	"Fumiko" : 0.5
}
var already_eaten = { #SAVE
	"Regina" : false,
	"Maxim"  : false,
	"Nashir" : false,
	"Fumiko" : false
}
var already_medicine = { #SAVE
	"Regina" : false,
	"Maxim"  : false,
	"Nashir" : false,
	"Fumiko" : false
}
var already_talk = { #SAVE
	"Regina" : false,
	"Maxim"  : false,
	"Nashir" : false,
	"Fumiko" : false
}
var already_vitamins = { #SAVE
	"Regina" : false,
	"Maxim"  : false,
	"Nashir" : false,
	"Fumiko" : false
}

var _current_hunger = { #SAVE
	"Regina" : 0.5,
	"Maxim"  : 0.5,
	"Nashir" : 0.5,
	"Fumiko" : 0.5
}
var _rationConsumes = { #SAVE
	"Regina" : 5,
	"Maxim" : 10,
	"Nashir" : 5,
	"Fumiko" : 5
}
var _sanity = { #SAVE
	"Regina" : 0.5,
	"Maxim"  : 0.5,
	"Nashir" : 0.5,
	"Fumiko" : 0.5
}
var _health = { #SAVE
	"Regina" : 0.5,
	"Maxim"  : 0.5,
	"Nashir" : 0.5,
	"Fumiko" : 0.5
}
var _disease = { #SAVE
	"Regina" : 0.0,
	"Maxim"  : 0.0,
	"Nashir" : 0.0,
	"Fumiko" : 0.0
}
var _Survivability = { #SAVE
	"Regina" : 0.3,
	"Maxim" : 0.6,
	"Nashir" : 0.3,
	"Fumiko" : 0.3
}
var _LootCapability = { #SAVE
	"Regina" : 0.5,
	"Maxim" : 0.3,
	"Nashir" : 0.5,
	"Fumiko" : 0.6
}
var _Knowledge = { #SAVE
	"Regina" : 1,
	"Maxim" : 1,
	"Nashir" : 1,
	"Fumiko" : 1
}
var _reginaRelationship = { #SAVE
	"Maxim"  : 0.0,
	"Nashir" : 0.0,
	"Fumiko" : 0.0
}
var _MaximRelationship = { #SAVE
	"Regina" : 0.0,
	"Nashir" : 0.0,
	"Fumiko" : 0.0
}
var _NashirRelationship = { #SAVE
	"Regina" : 0.0,
	"Maxim"  : 0.0,
	"Fumiko" : 0.0
}
var _FumikoRelationship = { #SAVE
	"Regina" : 0.0,
	"Maxim"  : 0.0,
	"Nashir" : 0.0,
	"Fumiko" : 0.0
}
func addRelationshipBetweenCrew(FromCrewName : String,ToCrewName_CAPS, value : bool):
	match (ToCrewName_CAPS):
		"MAXIM": 
			for crew in _MaximRelationship.keys():
				if crew == FromCrewName:
					_MaximRelationship[crew] += value
		"REGINA": 
			for crew in _reginaRelationship.keys():
				if crew == FromCrewName:
					_reginaRelationship[crew] += value
		"NASHIR": 
			for crew in _NashirRelationship.keys():
				if crew == FromCrewName:
					_NashirRelationship[crew] += value
		"FUMIKO": 
			for crew in _FumikoRelationship.keys():
				if crew == FromCrewName:
					_FumikoRelationship[crew] += value
		"JERRY": 
			for crew in _relationship.keys():
				if crew == FromCrewName:
					_relationship[crew] += value
func crewEat(CrewName : String, foodValue : int)  -> int:
	if foodValue < _rationConsumes[CrewName]:
		return foodValue
	_current_hunger[CrewName] = 100
	return foodValue - _rationConsumes[CrewName]

func reduceFood(value : int):
	GlobalResources.ration = value

func doHunger():
	for crew in crew_in_ship:
		if _current_hunger.has(crew):
			_current_hunger[crew] -=randf() * 0.3 + 0.12
			if _current_hunger[crew] < 0.0 : _current_hunger[crew] = 0.0

func doHealthChecker():
	for crew in crew_in_ship:
		if _health.has(crew):
			if _current_hunger[crew] == 0.0:
				_health[crew] -= 0.2
			if _disease[crew] == 1.0:
				_health[crew] -= 0.2
			if _health[crew] <= 0.0:#DEATH, KULANG PA
				var message = crew + " has gone missing..."
				addOnCycleReportList(message)
				crew_in_ship.erase(crew)
				recent_events.append("DEATH")


func doSanity():
	for crew in crew_in_ship:
		if _sanity.has(crew):
			var grief = 0.0
			if recent_events.has("DEATH") or recent_events.has("2DAYDEATH") or recent_events.has("3DAYDEATH"): grief = 0.25
			_sanity[crew] -= (randf()*0.035) + 0.01 + grief

func doDisease():
	for crew in crew_in_ship:
		if _disease[crew] != 0.0 or _disease[crew] != 0:
			var immunity = 0.0
			if already_vitamins[crew]: immunity = 0.05
			var disease_progression = (randf() * 0.2 + (getNumberOfDisease() * 0.04)) - immunity
			if disease_progression < 0.0: disease_progression = 0.0
			_disease[crew] += disease_progression
		elif getNumberOfDisease() > 0:
			var immunity = 0.0
			if already_vitamins[crew]: immunity = 0.15
			var chance = randf() * 1.0
			if chance > (0.8 + immunity): _disease[crew] = 0.0001

func doOxygen():
	for crew in crew_in_ship:
		if GlobalResources.oxygen <= 0:  # If no oxygen is left
			if GlobalResources.emergencyOxy <= 0: 
				pass # GAME OVER
			else:
				addOnCycleReportList("EmergencyOxygen -5")
				GlobalResources.emergencyFuel -= 5
				if GlobalResources.emergencyFuel < 0: GlobalResources.emergencyFuel = 0
		else:
			var oxygen_consumption = 5  # How much oxygen is consumed each cycle
			GlobalResources.oxygen -= oxygen_consumption  # Subtract from oxygen
			if GlobalResources.oxygen >= 0:  # If there's still oxygen left (or zero)
				var oxygen_report =  "Oxygen -" + str(oxygen_consumption)
				addOnCycleReportList(oxygen_report)
			else:  # If oxygen goes negative, handle the excess consumption
				var excessConsumption = GlobalResources.oxygen * -1  # Convert to positive excess
				GlobalResources.oxygen = 0  # Set oxygen to 0 since it's depleted
				
				var oxygen_report = "Oxygen -" + str(oxygen_consumption - excessConsumption)
				addOnCycleReportList(oxygen_report)
				
				# Handle excess by using emergency oxygen
				if GlobalResources.emergencyOxy > 0 and excessConsumption > 0:
					var emergency_report = "EmergencyOxygen -" + str(excessConsumption)
					addOnCycleReportList(emergency_report)
					
					GlobalResources.emergencyOxy -= excessConsumption  # Subtract excess from emergency oxygen
					
					if GlobalResources.emergencyOxy < 0:  # Ensure emergency oxygen doesn't go negative
						GlobalResources.emergencyOxy = 0
					if GlobalResources.emergencyOxy <= 0:
						pass ## Handle game over here if needed
	print(Cycle_ReportList)

func getNumberOfDisease() -> int:
	var disease_count = 0
	for crew in crew_in_ship:
		if _disease[crew] != 0.0 or _disease[crew] != 0:
			disease_count += 1
	return disease_count

func resetPerDay():
	for i in already_talk.keys():
		already_talk[i] = false
	for i in already_eaten.keys():
		already_eaten[i] = false
	for i in already_medicine.keys():
		already_medicine[i] = false

####DIALOGUE DATA
var AlreadyTriggeredDialogueEvent = []
