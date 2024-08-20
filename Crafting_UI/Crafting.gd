extends Node

@onready var getResources = $"/root/GlobalResources"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var craftingItems

func craft():
	match craftingItems:
		"SpaceSuit":
			if getResources.spareparts >= 300 && getResources.oxygen <= 100 && getResources.fuel <= 10:
				getResources.spareparts -= 300
				getResources.oxygen -= 100
				getResources.fuel -= 10
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"HazmatSuit":
			if getResources.spareparts >= 400 && getResources.fuel <= 10:
				getResources.spareparts -= 400
				getResources.fuel -= 10
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"Crowbar":
			if getResources.spareparts >= 350 && getResources.fuel <= 10:
				getResources.spareparts -= 350
				getResources.fuel -= 10
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"LaserGun":
			if getResources.spareparts >= 350 && getResources.biogene >= 20 && getResources.fuel <= 10:
				getResources.spareparts -= 350
				getResources.biogene -= 20
				getResources.fuel -= 10
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"MedkitCharge":
			if getResources.biogene >= 150 && getResources.fuel <= 10:
				getResources.biogene -= 150
				getResources.fuel -= 10
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"DehySpaceFood":
			if getResources.biogene >= 100 && getResources.fuel <= 10:
				getResources.biogene -= 150
				getResources.fuel -= 10
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
			
		"FreDriSpaceFood":
			if getResources.ration >= 20 && getResources.fuel <= 10:
				getResources.ration -= 20
				getResources.fuel -= 10
				print("Successfully Made!")
			else:
				print("Insufficient Items!")
	pass
