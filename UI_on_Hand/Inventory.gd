extends Control
const MAX_SLOTS = 4

#Extension Scripts
@onready var Hand1 = $Hand_1/Sprite2D
@onready var Hand2 = $Hand_2/Sprite2D
@onready var Hand3 = $Hand_3/Sprite2D
@onready var Hand4 = $Hand_4/Sprite2D
@onready var resource = GlobalResources

#Texture Packages
var battery_texture = load("res://Resources/Small_Fuel_1_unpickup.png")
var apple_texture = load("res://Resources/resources 1.png")
var small_biogene_texture = load("res://Resources/Resource_Images/SmallBiogene_OnHand.png")
var spareparts_texture = load("res://Resources/Resource_Images/SmallSpareparts_Unpickup_variety1.png")
var oxygenGasTank_small = load("res://Resources/SmallOxygenGas/Small_SmallOxygenGas.png")
var KeyCard = load("res://Scenes/Tutorial/KeyCard.png")
var teddyBear = load("res://Resources/Resource_Images/TeddyBear Icon.png")

var inventory = []  


func _ready():
	for i in range(MAX_SLOTS): #Declaration of inventory size
		inventory.append([])
	showItem()

func _insert_all_items(): #Declaration of inventory size
	for i in range(MAX_SLOTS):
		for item in inventory[i]:
			var r = NodeFinder.find_node_by_name(get_tree().current_scene, "ResourceUI_InRun")
			r.add_item(item)    #CHANGE THIS
	insertAllItems()
	showItem()

func showItem():
	var hands = [Hand1, Hand2, Hand3, Hand4]
	
	for hand in hands:
		hand.texture = null
		
	for i in range(MAX_SLOTS):
		if i < hands.size() and "Small Fuel" in inventory[i]:
			hands[i].scale = Vector2(0.25,0.25)
			hands[i].texture = battery_texture
			print("Detected battery in slot ", i + 2)
		elif i < hands.size() and "Small Spareparts" in inventory[i]:
			hands[i].scale = Vector2(0.45,0.45)
			hands[i].texture = spareparts_texture
			print("Detected apple in slot ", i + 1)
		elif i < hands.size() and "Small Biogene" in inventory[i]:
			hands[i].scale = Vector2(0.30,0.30)
			hands[i].texture = small_biogene_texture
		elif i < hands.size() and "Small Gastank" in inventory[i]:
			hands[i].scale = Vector2(0.30,0.30)
			hands[i].texture = oxygenGasTank_small
		elif i < hands.size() and "KeyCard" in inventory[i]:
			hands[i].scale = Vector2(0.30,0.30)
			hands[i].texture = KeyCard
		elif i < hands.size() and "TeddyBear" in inventory[i]:
			hands[i].scale = Vector2(0.30,0.30)
			hands[i].texture = teddyBear
		else:
			hands[i].texture = null



func addItem(itemType, slotsNeeded):
	if slotsNeeded <= 0 or slotsNeeded > MAX_SLOTS:
		print("Invalid number of slots needed.")
		return false
	var remainingSlots = getRemainingSlots()
	if slotsNeeded > remainingSlots:
		var indicator = NodeFinder.find_node_by_name(get_tree().current_scene, "FullInventoryIndicator")
		indicator.onStart()
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

func insertAllItems():
	for i in range(MAX_SLOTS):
		inventory[i].clear()


#NONE VOID METHODS
func getRemainingSlots(): #Returns remaining slots
	var usedSlots = 0
	for i in range(MAX_SLOTS):
		if inventory[i].size() > 0:
			usedSlots += 1
	return MAX_SLOTS - usedSlots

func getUsedSlots(): #Returns used slots
	var usedSlots = 0
	for i in range(MAX_SLOTS):
		if inventory[i].size() > 0:
			usedSlots += 1
	return usedSlots

func getSpeedPenalty(): #Return penalty speed, Carrying more items decrease player movement speed
	return (getRemainingSlots() * 20) - (MAX_SLOTS * 20)
