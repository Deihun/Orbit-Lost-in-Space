extends Node


#VARIABLES 
var ration = 0
var fuel = 0
var oxygen = 0
var spareparts = 0
var biogene : int= 0
var ductape : int = 0
var medicine: int = 0
var emergencyOxy = 10
var emergencyFuel = 10

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

func ConsumeFuel(value: int = 10) -> bool:
	if oxygen >= value:
		oxygen -= value
	else:
		value -= oxygen
		oxygen = 0
		if emergencyFuel >= value:
			emergencyFuel -= value
		else:
			emergencyFuel = 0
			return false
	
	return true

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
	item_type = item_type.to_upper()
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
	item_name = item_name.to_upper()
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
	print(item_name,amount)
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
			_:
				print("unrecognize item ", item_name)

func reset(item_type):
	match(item_type):
		"SPAREPARTS":
			var value = spareparts * -1
			IngameStoredProcessSetting.addOnCycleReportList(str("Spareparts -", value))
			spareparts = 0
		"FOOD":
			var value = ration * -1
			IngameStoredProcessSetting.addOnCycleReportList(str("Spareparts -", value))
			ration = 0 
		"FUEL":
			var value = fuel * -1
			IngameStoredProcessSetting.addOnCycleReportList(str("Spareparts -", value))
			fuel = 0 
		"BIOGENE":
			var value = biogene * -1
			IngameStoredProcessSetting.addOnCycleReportList(str("Spareparts -", value))
			biogene = 0 
		"DUCTAPE":
			var value = ductape * -1
			IngameStoredProcessSetting.addOnCycleReportList(str("Spareparts -", value))
			ductape = 0 
		"OXYGEN": 
			var value = oxygen * -1
			IngameStoredProcessSetting.addOnCycleReportList(str("Spareparts -", value))
			oxygen = 0

func addGameEffect(name):
	GameEffects.append(name)

func checkEffect(effect_name):
	return GameEffects.has(effect_name)

func removeEffect(effect_name):
	GameEffects.erase(effect_name)
