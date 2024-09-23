extends Node
#VARIABLE 
var Cycle = 0


func newGame():
	Cycle = 1


func endCycle():
	Cycle += 1
	move_space()


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

func addOnCycleReportList(report : String):
	var split = report.split(" ")
	var name = split[0]
	print("Report: ",report)
	var value = split[1]
	var index : int = 0
	for each in Cycle_ReportList:
		if each[0] == name:
			break
		else:
			index += 1
	if Cycle_ReportList.size() > 0:
		if Cycle_ReportList[0].has(name):
			Cycle_ReportList[index][1] += int(value)
		else:
			Cycle_ReportList.append([name, int(value)])
	else:
		Cycle_ReportList.append([name, int(value)])
	pass
	
	print(Cycle_ReportList)
