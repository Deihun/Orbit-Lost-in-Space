extends Node

#VARIABLES 
const MAX_SLOTS = 4
var inventory = []  

#VOID METHODS
func showItem(): #DEBUG: Display each name of items in inventory array
	print("Inventory: ", inventory)


func _ready(): #init inventory array
	for i in range(MAX_SLOTS):
		inventory.append([])
	showItem() 


func addItem(itemType, slotsNeeded): #Multiple checks to avoid debug when adding items
	if slotsNeeded <= 0 or slotsNeeded > MAX_SLOTS:
		print("Invalid number of slots needed.")
		return false
	var remainingSlots = getRemainingSlots()
	if slotsNeeded > remainingSlots:
		print("Not enough space in the inventory.")
		return false
	var startIndex = findAvailableSlots(slotsNeeded)
	if startIndex == -1:
		print("Could not find enough consecutive slots.")
		return false
		
	for i in range(slotsNeeded): 
		inventory[startIndex + i].append(itemType)
	return true


func findAvailableSlots(slotsNeeded):
	for i in range(MAX_SLOTS - slotsNeeded + 1):
		var slotsAvailable = true
		for j in range(slotsNeeded):
			if inventory[i + j].size() > 0:
				slotsAvailable = false
				break
		if slotsAvailable:
			return i
	return -1


func getRemainingSlots():
	var usedSlots = 0
	for i in range(MAX_SLOTS):
		if inventory[i].size() > 0:
			usedSlots += 1
	return MAX_SLOTS - usedSlots


func insertAllItems():
	for i in range(MAX_SLOTS):
		inventory[i].clear()

