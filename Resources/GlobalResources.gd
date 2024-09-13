extends Node

#VARIABLES
var ration = 0
var fuel = 0
var oxygen = 0
var spareparts = 100
var biogene = 0
var ductape : int = 0
var emergencyOxy = 0
var emergencyFuel = 0

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

func subtractItem(conditions,item_name, amount):
	if conditions:
		match(item_name):
			"SPAREPARTS":
				spareparts -= amount
			"FOOD":
				ration -= amount 
			"FUEL":
				fuel -= amount 
			"BIOGENE":
				biogene -= amount 
			"DUCTAPE":
				ductape -= amount 
			"OXYGEN":
				oxygen -= amount

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
