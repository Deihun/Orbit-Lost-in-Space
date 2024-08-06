extends Node

var food = 0
var fuel = 0


func add_item(item_type):
	match(item_type):
		#Food items
		"Apple":
			print("submitted apple")
			food += 10
		#Misc items
		"Small Battery":
			print("submitted fuel")
			fuel += 13
	print("the item is: ", item_type)

func showTotalItems():
	print("Food: ",food," Fuel: ", fuel)
