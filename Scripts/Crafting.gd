extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var craftingItems
var GetSpareParts
var GetOxygen
var GetBiogene
var GetFoodRation

func craft():
	match craftingItems:
		"SpaceSuit":
			if GetSpareParts >= 300 && GetOxygen <= 100:
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"HazmatSuit":
			if GetSpareParts >= 400:
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"Crowbar":
			if GetSpareParts >= 350:
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"LaserGun":
			if GetSpareParts >= 350 && GetBiogene >= 20:
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"MedkitCharge":
			if GetBiogene >= 150:
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"DehySpaceFood":
			if GetBiogene >= 100:
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"FreDriSpaceFood":
			if GetFoodRation >= 20:
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
	pass
