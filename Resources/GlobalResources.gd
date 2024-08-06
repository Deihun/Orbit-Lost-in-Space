extends Node

#VARIABLES
var food = 0
var fuel = 0
var spareparts = 0
var biogene = 0
var ductape = 0


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
