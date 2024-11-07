extends Node


#VARIABLES 
var ration = 125
var fuel = 100
var oxygen = 100
var spareparts = 0
var biogene : int= 0
var ductape : int = 0
var medicine: int = 0
var emergencyOxy : int= 100
var emergencyFuel :int = 100

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
	print("HAS ITEM: ", item_type, quantity)
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
		"MEDKIT":
			returningValue = medicine >= quantity
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
			"MEDKIT":
				IngameStoredProcessSetting.addOnCycleReportList(str("Medicine -", amount))
				medicine -= amount

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
			"MEDKIT":
				IngameStoredProcessSetting.addOnCycleReportList(str("Medicine -", amount))
				medicine += amount
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

func deduct_oxygen(value: int = 5) -> bool:
	var oxygenColludedValue = 0
	var emergencyoxygenColludedValue = 0
	print(oxygen, " - ", emergencyOxy, " ", value)
	for i in range(value):
		# Deduct from oxygen if there is any left.
		if oxygen > 0:
			oxygen -= 1
			oxygenColludedValue+=1
			
		# If oxygen is depleted, start deducting from emergency oxygen.
		elif emergencyOxy > 0 and oxygen <= 0:
			emergencyOxy -= 1
			emergencyoxygenColludedValue += 1

	if oxygenColludedValue > 0 : IngameStoredProcessSetting.addOnCycleReportList(str("Oxygen -",oxygenColludedValue))
	if emergencyoxygenColludedValue > 0 : IngameStoredProcessSetting.addOnCycleReportList(str("EmergencyOxygen -",emergencyoxygenColludedValue))

	return emergencyOxy <= 0


func deduct_fuel(value: int = 5) -> bool:
	var oxygenColludedValue = 0
	var emergencyoxygenColludedValue = 0
	for i in range(value):
		# Deduct from oxygen if there is any left.
		if fuel > 0:
			fuel -= 1
			oxygenColludedValue+=1
			
		# If oxygen is depleted, start deducting from emergency oxygen.
		elif emergencyFuel > 0 and oxygen <= 0:
			emergencyFuel -= 1
			emergencyoxygenColludedValue += 1

	if oxygenColludedValue > 0 : IngameStoredProcessSetting.addOnCycleReportList(str("Fuel -",oxygenColludedValue))
	if emergencyoxygenColludedValue > 0 : IngameStoredProcessSetting.addOnCycleReportList(str("EmergencyFuel -",emergencyoxygenColludedValue))

	return emergencyFuel <= 0
