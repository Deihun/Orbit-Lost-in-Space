extends Control
var MAX_SLOTS : int = 4

#Extension Scripts
@onready var Hand1 = $Hand_1/Sprite2D
@onready var Hand2 = $Hand_2/Sprite2D
@onready var Hand3 = $Hand_3/Sprite2D
@onready var Hand4 = $Hand_4/Sprite2D
@onready var Hand5 = $Hand_5/Sprite2D
@onready var Hand6 = $Hand_6/Sprite2D
@onready var resource = GlobalResources

#Texture Packages
var battery_texture = load("res://Resources/Small_Fuel_1_unpickup.png")
var smallfood = load("res://Resources/SmallFoodCan/SmallFood_PickUp.png")
var ductape = load("res://Resources/DuctapePickup.png")
var medicine = load("res://Resources/FirstAidKit/Medicine_Pickup.png")
var small_biogene_texture = load("res://Resources/Small_Biogene/BiogenePickup.png")
var spareparts_texture = load("res://Resources/Spareparts/SparepartsPickup.png")
var oxygenGasTank_small = load("res://Resources/SmallOxygenGas/OxygenPickup.png")
var KeyCard = load("res://Scenes/Tutorial/KeyCard.png")
var teddyBear = load("res://Resources/Resource_Images/TeddyBear Icon.png")

var _regina_icon = load("res://Resources/CREW/REGINA PICK UP.png")
var _maxim_icon = load("res://Resources/CREW/MAXIM.png")
var _fumiko_icon = load("res://Resources/CREW/Fumiko PickUp.png")
var _nashir_icon = load("res://Resources/CREW/Nashir_pickup.png")

var inventory = []  


func _ready():
	MAX_SLOTS = IngameStoredProcessSetting.inventory
	MAX_SLOTS = 6 if MAX_SLOTS > 6 else MAX_SLOTS
	
	for i in range(MAX_SLOTS): #Declaration of inventory size
		inventory.append([])
	showItem()
	match MAX_SLOTS:
		4:
			$Hand_5.hide()
			$Hand_6.hide()
		5:
			$Hand_5.show()
			$Hand_6.hide()
		6:
			$Hand_5.show()
			$Hand_6.show()

func _insert_all_items(): #Declaration of inventory size
	for i in range(MAX_SLOTS):
		for item in inventory[i]:
			var r = NodeFinder.find_node_by_name(get_tree().current_scene, "ResourceUI_InRun")
			r.add_item(item)    #CHANGE THIS
	insertAllItems()
	showItem()

func showItem():
	var hands = [Hand1, Hand2, Hand3, Hand4, Hand5, Hand6]
	
	for hand in hands:
		hand.texture = null
		
	for i in range(MAX_SLOTS):
		if i < hands.size() and "Small Fuel" in inventory[i]:
			hands[i].scale = Vector2(0.25,0.25)
			hands[i].texture = battery_texture
			print("Detected battery in slot ", i + 2)
		elif i < hands.size() and "Small Spareparts" in inventory[i]:
			hands[i].scale = Vector2(0.25,0.25)
			hands[i].texture = spareparts_texture
			print("Detected apple in slot ", i + 1)
		elif i < hands.size() and "Small Food" in inventory[i]:
			hands[i].scale = Vector2(0.2,0.2)
			hands[i].texture = smallfood
			print("Detected apple in slot ", i + 1)
		elif i < hands.size() and "Ductape" in inventory[i]:
			hands[i].scale = Vector2(0.45,0.45)
			hands[i].texture = ductape
			print("Detected apple in slot ", i + 1)
		elif i < hands.size() and "Medicine Pack" in inventory[i]:
			hands[i].scale = Vector2(0.2,0.2)
			hands[i].texture = medicine
			print("Detected apple in slot ", i + 1)
		elif i < hands.size() and "Small Biogene" in inventory[i]:
			hands[i].scale = Vector2(0.30,0.30)
			hands[i].texture = small_biogene_texture
		elif i < hands.size() and "Small Gastank" in inventory[i]:
			hands[i].scale = Vector2(0.25,0.25)
			hands[i].texture = oxygenGasTank_small
		elif i < hands.size() and "KeyCard" in inventory[i]:
			hands[i].scale = Vector2(0.30,0.30)
			hands[i].texture = KeyCard
		elif i < hands.size() and "TeddyBear" in inventory[i]:
			hands[i].scale = Vector2(0.30,0.30)
			hands[i].texture = teddyBear
		elif i < hands.size() and "Regina" in inventory[i]:
			hands[i].scale = Vector2(0.15,0.15)
			hands[i].texture = _regina_icon
		elif i < hands.size() and "Maxim" in inventory[i]:
			hands[i].scale = Vector2(0.15,0.15)
			hands[i].texture = _maxim_icon
		elif i < hands.size() and "Nashir" in inventory[i]:
			hands[i].scale = Vector2(0.15,0.15)
			hands[i].texture = _nashir_icon
		elif i < hands.size() and "Fumiko" in inventory[i]:
			hands[i].scale = Vector2(0.15,0.15)
			hands[i].texture = _fumiko_icon
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

func hasItem(item : String):
	print(inventory)
	return inventory[0].has(item)
