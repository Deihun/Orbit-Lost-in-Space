extends Node

@onready var getResources = $"/root/GlobalResources"
@onready var SaveLoadGame = $Control
var craftingItems

func craft_button_pressed() -> void:
	match craftingItems:
		"SpaceSuit":
			if getResources.spareparts >= 300 && getResources.oxygen >= 100 && getResources.fuel >= 10:
				getResources.spareparts -= 300
				getResources.oxygen -= 100
				getResources.fuel -= 10
				getResources.uniqueItems.append(craftingItems)
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"HazmatSuit":
			if getResources.spareparts >= 400 && getResources.fuel >= 10:
				getResources.spareparts -= 400
				getResources.fuel -= 10
				getResources.uniqueItems.append(craftingItems)
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"Crowbar":
			if getResources.spareparts >= 350 && getResources.fuel >= 10:
				getResources.spareparts -= 350
				getResources.fuel -= 10
				getResources.uniqueItems.append(craftingItems)
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"LaserGun":
			if getResources.spareparts >= 350 && getResources.biogene >= 20 && getResources.fuel >= 10:
				getResources.spareparts -= 350
				getResources.biogene -= 20
				getResources.fuel -= 10
				getResources.uniqueItems.append(craftingItems)
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"MedkitCharge":
			if getResources.biogene >= 150 && getResources.fuel >= 10:
				getResources.biogene -= 150
				getResources.fuel -= 10
				getResources.uniqueItems.append(craftingItems)
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"DehySpaceFood":
			if getResources.biogene >= 100 && getResources.fuel >= 10:
				getResources.biogene -= 150
				getResources.fuel -= 10
				getResources.uniqueItems.append(craftingItems)
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"FreDriSpaceFood":
			if getResources.ration >= 20 && getResources.fuel >= 10:
				getResources.ration -= 20
				getResources.fuel -= 10
				getResources.uniqueItems.append(craftingItems)
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
		_:
			print("Select a Item")
	pass


func add_res_pressed() -> void:
	getResources.spareparts += 1000
	getResources.oxygen += 1000
	getResources.fuel += 1000
	getResources.biogene += 1000
	getResources.ration += 1000
	print(getResources.spareparts, " ", getResources.oxygen, " ", getResources.fuel, " ", getResources.biogene, " ", getResources.ration)
	pass # Replace with function body.

func check_res_pressed() -> void:
	print(getResources.spareparts, " ", getResources.oxygen, " ", getResources.fuel, " ", getResources.biogene, " ", getResources.ration)
	print(getResources.uniqueItems)
	pass # Replace with function body.

func space_suit_pressed() -> void:
	craftingItems = "SpaceSuit"
	print("Selected Space suit")
	pass # Replace with function body.

func crowbar_pressed() -> void:
	craftingItems = "Crowbar"
	print("Selected Crowbar")
	pass # Replace with function body.

func laser_gun_pressed() -> void:
	craftingItems = "LaserGun"
	print("Selected Laser Gun")
	pass # Replace with function body.

func _on_dehy_space_food_pressed() -> void:
	craftingItems = "DehySpaceFood"
	print("Selected DehySpaceFood")
	pass # Replace with function body.

func medkit_charge_pressed() -> void:
	craftingItems = "MedkitCharge"
	print("Selected MedkitCharge")
	pass # Replace with function body.

func fre_dri_space_food_pressed() -> void:
	craftingItems = "FreDriSpaceFood"
	print("Selected FreDriSpaceFood")
	pass # Replace with function body.

func hazmat_suit_pressed() -> void:
	craftingItems = "HazmatSuit"
	print("Selected HazmatSuit")
	pass # Replace with function body.


func _on_save_button_debug_pressed() -> void:
	#var isPlayerInside = NodeFinder.find_node_by_name(get.tree().current_scene, "Player_Final_Count")
	SaveLoadGame.save()
		
	
func _on_load_button_debug_pressed() -> void:
	SaveLoadGame.load()
