extends Node


#VARIABLES 
var ration = 0
var fuel = 0
var oxygen = 1000
var spareparts = 10000000
var biogene = 0
var ductape : int = 0
var medicine: int = 0
var emergencyOxy = 0
var emergencyFuel = 0

#EVENT VARIABLES
var Critical_Event = []
var alreadyTriggeredEvent = []
var Priority_Event = []
var eventID = []
var currentActiveQueue : int = 0


#

var GameEffects = [] 
var uniqueItems = []

var Location = "Space"

func add_item(item_type):#Use to direct add items, used by other objects such as dropbox to add items
	match(item_type):
		"Small Food":
			print("submitted apple")
			ration += 10
		"Small Fuel":
			print("submitted fuel")
			fuel += 13
		"Small Spareparts":
			spareparts += 15
		"Small Biogene":
			biogene += 15
		"ductape":
			ductape += 1

func hasItem(item_type: String, quantity: int) -> bool:
	var returningValue = false
	match(item_type):
		"FOOD":
			returningValue = ration >= quantity 
		"FUEL":
			returningValue = fuel >= quantity
		"SPAREPARTS":
			returningValue = spareparts >= quantity
		"BIOGENE":
			returningValue = biogene >= quantity
		"DUCTAPE":
			returningValue = ductape >= quantity
		"OXYGEN":
			returningValue = oxygen >= quantity
	return returningValue

func showTotalItems(): #For DEBUG only
	print("Ration: ",ration," Fuel: ", fuel," Spareparts: ", spareparts, " biogene: ", biogene, " Ductape: ", ductape)

func getSpareparts():
	return spareparts

func subtractItem(conditions : bool,item_name : String, amount : int):
	if conditions:
		match(item_name):
			"SPAREPARTS":
				IngameStoredProcessSetting.addOnCycleReportList(str("Spareparts -", amount))
				spareparts -= amount
			"FOOD":
				IngameStoredProcessSetting.addOnCycleReportList(str("Food -", amount))
				ration -= amount 
			"FUEL":
				IngameStoredProcessSetting.addOnCycleReportList(str("Fuel -", amount))
				fuel -= amount 
			"BIOGENE":
				IngameStoredProcessSetting.addOnCycleReportList(str("Biogene -", amount))
				biogene -= amount 
			"DUCTAPE":
				IngameStoredProcessSetting.addOnCycleReportList(str("Ductape -", amount))
				ductape -= amount 
			"OXYGEN":
				IngameStoredProcessSetting.addOnCycleReportList(str("Oxygen -", amount))
				oxygen -= amount

func AddItem(conditions,item_name, amount):#FOR EVENT ONLY
	if conditions:
		match(item_name):
			"SPAREPARTS":
				IngameStoredProcessSetting.addOnCycleReportList(str("Spareparts -", amount))
				spareparts += amount
			"FOOD":
				IngameStoredProcessSetting.addOnCycleReportList(str("Food -", amount))
				ration += amount 
			"FUEL":
				IngameStoredProcessSetting.addOnCycleReportList(str("Fuel -", amount))
				fuel += amount 
			"BIOGENE":
				IngameStoredProcessSetting.addOnCycleReportList(str("Biogene -", amount))
				biogene += amount 
			"DUCTAPE":
				IngameStoredProcessSetting.addOnCycleReportList(str("Ductape -", amount))
				ductape += amount 
			"OXYGEN":
				IngameStoredProcessSetting.addOnCycleReportList(str("Oxygen -", amount))
				oxygen += amount

func reset(item_type):
	match(item_type):
		"SPAREPARTS":
			spareparts = 0
		"FOOD":
			ration = 0 
		"FUEL":
			fuel = 0 
		"BIOGENE":
			biogene = 0 
		"DUCTAPE":
			ductape = 0 
		"OXYGEN": 
			oxygen = 0

func addGameEffect(name):
	GameEffects.append(name)

func checkEffect(effect_name):
	return GameEffects.has(effect_name)

func removeEffect(effect_name):
	GameEffects.erase(effect_name)
