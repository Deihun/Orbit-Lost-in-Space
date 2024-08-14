extends Node

#VARIABLES
var food = 0
var fuel = 0
var spareparts = 50
var biogene = 0
var ductape = 0
var GameEffects = [] 
var uniqueItems = []

func add_item(item_type):#Use to direct add items, used by other objects such as dropbox to add items
	match(item_type):
		"Small Food":
			print("submitted apple")
			food += 10
		"Small Fuel":
			print("submitted fuel")
			fuel += 13
		"Small Spareparts":
			spareparts += 15
		"Small Biogene":
			biogene += 15
		"ductape":
			ductape += 1


func showTotalItems(): #For DEBUG only
	print("Food: ",food," Fuel: ", fuel," Spareparts: ", spareparts, " biogene: ", biogene, " Ductape: ", ductape)

func getSpareparts():
	return spareparts

func subtractItem(conditions,item_name, amount):
	if conditions:
		match(item_name):
			"spareparts":
				spareparts -= amount

func reset(item_type):
	match(item_type):
		"Spareparts":
			spareparts = 0

func addGameEffect(name):
	GameEffects.append(name)

func checkEffect(effect_name):
	return GameEffects.has(effect_name)

func removeEffect(effect_name):
	GameEffects.erase(effect_name)

