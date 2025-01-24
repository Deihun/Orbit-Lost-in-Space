extends Node

var inventory = []


func add_fuel(item_name : String, max_capacity : int = 100, Value : int = 100):
	var battery = {
		"name" : item_name,
		"type" : "fuel",
		"value": Value,
		"max_capacity" : max_capacity
	}
	inventory.append(battery)


func add_oxygen(item_name : String, Value : int = 3):
	var oxygen = {
		"name" : item_name,
		"type" : "oxygen",
		"value": Value,
	}
	inventory.append(oxygen)


func add_food(item_name : String, food_amount : int, is_sealed : bool, expiration_countdown_per_cycle : int, expiration_total : int, morale_effect : float = 0.0):
	var food = {
		"name" : item_name, 
		"type" : "food",
		"food_amount" : food_amount,
		"is_sealed" : is_sealed,
		"expiration_countdown_per_cycle" : expiration_countdown_per_cycle,
		"expiration_total" : expiration_total,
		"moral_effect" : morale_effect
	}
	inventory.append(food)


func add_spare_item(item_name : String, Value : int):
	for item in inventory:
		if inventoryHas(item_name):
			item["value"] += Value
			return
	var spareparts = {
		"name" : item_name,
		"type" : "spare",
		"value" : Value
	}
	inventory.append(spareparts)


func add_artifact(item_name : String):
	for items in inventory:
		if items["name"] == item_name: return
	var artifact = {
		"name" : item_name
	}


func inventoryHas(item_name):
	for each in inventory:
		if each["name"] == item_name: return true
	return false
