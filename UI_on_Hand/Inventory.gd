extends Control
var MAX_SLOTS : int = 4

#Extension Scripts
@onready var Hand1 = $Hand_1/Sprite2D
@onready var Hand2 = $Hand_2/Sprite2D
@onready var Hand3 = $Hand_3/Sprite2D
@onready var Hand4 = $Hand_4/Sprite2D
@onready var Hand5 = $Hand_5/Sprite2D
@onready var Hand6 = $Hand_6/Sprite2D
@onready var Hand7 = $Hand_7/Sprite2D
@onready var Hand8 = $Hand_8/Sprite2D
@onready var Hand9 = $Hand_9/Sprite2D
@onready var Hand10 = $Hand_10/Sprite2D
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
var true_inventory = []


func _ready():
	await get_tree().create_timer(0.01).timeout
	MAX_SLOTS = IngameStoredProcessSetting.inventory
	print(MAX_SLOTS)
	MAX_SLOTS = 6 if MAX_SLOTS > 6 else MAX_SLOTS
	for i in range(MAX_SLOTS): #Declaration of inventory size
		inventory.append([])
	showItem()
	updateUICount()

func updateUICount():
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
		7:
			$Hand_5.show()
			$Hand_6.show()
			$Hand_7.show()
		8:
			$Hand_5.show()
			$Hand_6.show()
			$Hand_7.show()
			$Hand_8.show()
		9:
			$Hand_5.show()
			$Hand_6.show()
			$Hand_7.show()
			$Hand_8.show()
			$Hand_9.show()
		10:
			$Hand_5.show()
			$Hand_6.show()
			$Hand_7.show()
			$Hand_8.show()
			$Hand_9.show()
			$Hand_10.show()


func _input(event: InputEvent) -> void: #DROP ITEM
	var player_group = $"../../.."
	if event.is_action("ui_drop_item"):
		for items in true_inventory:
			var sf
			match(items):
				"Small Fuel":
					sf = preload("res://Resources/Small_Fuel/Small Fuel.tscn").instantiate()

				"Small Spareparts":
					sf = preload("res://Resources/small_spareparts.tscn").instantiate()

				"Small Food":
					sf = preload("res://Resources/SmallFood.tscn").instantiate()

				"Ductape":
					sf = preload("res://Resources/Ductape.tscn").instantiate()

				"Medicine Pack":
					sf = preload("res://Resources/FirstAidKit/MedicinePack.tscn").instantiate()

				"Small Biogene":
					sf = preload("res://Resources/Small_Biogene/Small Biogene.tscn").instantiate()
				"Small Gastank":
					sf = preload("res://Resources/SmallOxygenGas/Small_OxygenTank.tscn").instantiate()
				"TeddyBear":
					sf = preload("res://Scenes/Tutorial/teddy_bear.tscn").instantiate()
				"Regina":
					sf = preload("res://Resources/CREW/Regina.tscn").instantiate()
				"Maxim":
					sf = preload("res://Resources/CREW/Maxim.tscn").instantiate()
				"Nashir":
					sf = preload("res://Resources/CREW/Nashir.tscn").instantiate()
				"Fumiko":
					sf = preload("res://Resources/CREW/Fumiko.tscn").instantiate()
			player_group.add_child(sf)
			sf.inventory = self
			sf.global_position = $"../../Player".global_position
		insertAllItems()
		showItem()



func set_max_slots(new_max_slots: int):
	new_max_slots = clamp(new_max_slots, 1, 10)
	
	if new_max_slots > MAX_SLOTS:
		# Increase the number of slots
		for i in range(MAX_SLOTS, new_max_slots):
			inventory.append([])
	elif new_max_slots < MAX_SLOTS:
		# Decrease the number of slots
		# First, collect any items in the slots that will be removed
		for i in range(new_max_slots, MAX_SLOTS):
			if inventory[i].size() > 0:
				# Here you can decide what to do with items in removed slots
				# e.g., move them to another list, discard them, or notify the player
				print("Slot", i, "contains items that will be lost:", inventory[i])
		
		# Trim the inventory to the new size
		inventory.resize(new_max_slots)

	MAX_SLOTS = new_max_slots
	updateUICount()
	update_ui_slots()


func update_ui_slots():
	# Update UI to show or hide slot nodes based on MAX_SLOTS
	var hands = [Hand1, Hand2, Hand3, Hand4, Hand5, Hand6, Hand7, Hand8, Hand9, Hand10]
	for i in range(hands.size()):
		if i < MAX_SLOTS:
			hands[i].show()
		else:
			hands[i].hide()
	
	showItem()  # Update the item display to reflect the new slot configuration


func _insert_all_items(): #Declaration of inventory size
	for i in range(MAX_SLOTS):
		for item in inventory[i]:
			var r = NodeFinder.find_node_by_name(get_tree().current_scene, "ResourceUI_InRun")
			r.add_item(item)    #CHANGE THIS
	true_inventory.clear()
	insertAllItems()
	showItem()

func showItem():
	var hands = [Hand1, Hand2, Hand3, Hand4, Hand5, Hand6,Hand7,Hand8,Hand9,Hand10]
	
	for hand in hands:
		hand.texture = null
		
	for i in range(MAX_SLOTS):
		if i < hands.size() and "Small Fuel" in inventory[i]:
			hands[i].scale = Vector2(0.25,0.25)
			hands[i].texture = battery_texture
		elif i < hands.size() and "Small Spareparts" in inventory[i]:
			hands[i].scale = Vector2(0.25,0.25)
			hands[i].texture = spareparts_texture
		elif i < hands.size() and "Small Food" in inventory[i]:
			hands[i].scale = Vector2(0.2,0.2)
			hands[i].texture = smallfood
		elif i < hands.size() and "Ductape" in inventory[i]:
			hands[i].scale = Vector2(0.45,0.45)
			hands[i].texture = ductape
		elif i < hands.size() and "Medicine Pack" in inventory[i]:
			hands[i].scale = Vector2(0.2,0.2)
			hands[i].texture = medicine
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
		return false
	var remainingSlots = getRemainingSlots()
	if slotsNeeded > remainingSlots:
		var indicator = NodeFinder.find_node_by_name(get_tree().current_scene, "FullInventoryIndicator")
		indicator.onStart()
		return false
	var startIndex = findAvailableSlots(slotsNeeded)
	if startIndex == -1:
		return false
		
	true_inventory.append(itemType)
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
	true_inventory.clear()


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
	return inventory[0].has(item)
