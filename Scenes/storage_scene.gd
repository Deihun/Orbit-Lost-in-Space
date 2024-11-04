extends Sprite2D

func _on_checking_medicine_mouse_entered() -> void:
	$CheckingMedicine/Storage_Medicine.show()
	$CheckingMedicine/Storage_Medicine/Medicine.text = str("Medicine: ", GlobalResources.medicine, "\n\nVital health resources used to treat injuries, cure ailments, and restore physical condition. Medicine can be found or crafted but is often in limited supply, making it essential to conserve for critical situations. Use medicine to heal wounds, counteract toxins, but manage it carefully to ensure you have enough for emergencies and prolonged survival of your crew.")

func _on_checking_biogene_mouse_entered() -> void:
	$CheckingBiogene/Storage_Biogene.show()
	$CheckingBiogene/Storage_Biogene/Biogene.text = str("Biogene: ", GlobalResources.biogene, "\n\nA rare, bio chemical material essential for crafting items or events. \nBiogene is found in limited quantities in expeditions and rewarded in events. \nUse Biogene in crafting Items, and manage it wisely, as supplies are scarce and highly valuable for game progression.")

func _on_checking_ration_mouse_entered() -> void:
	$CheckingRation/Storage_Ration.show()
	$CheckingRation/Storage_Ration/Ration.text = str("Food Ration: ", GlobalResources.ration, "\n\nThis is used by the crew to satisfy their hunger, \nIf the Food Ration has run out or not feeding the crew, the crew will get discontent and get angry at you, If continued not feeding the crew, the crew will starve to death")

func _on_checking_fuel_mouse_entered() -> void:
	$CheckingFuel/Storage_Fuel.show()
	$CheckingFuel/Storage_Fuel/Fuel.text = str("Fuel: ", GlobalResources.fuel,"/1000",
	"\nEmergency Fuel: ", GlobalResources.emergencyFuel,"/100",
	 "\n\nAn essential propulsion resource used to power and maneuver the spacecraft. Fuel depletes with each of movement of the Spacecraft, and depletes when crafting an Item, requiring careful management to ensure you have enough for both travel and crafting. Collect fuel cells in expeditions and events, and strategize the use of your fuel and avoid getting stranded in space")

func _on_checking_oxygen_mouse_entered() -> void:
	$CheckingOxygen/Storage_Oxygen.show()
	$CheckingOxygen/Storage_Oxygen/Oxygen.text = str("Oxygen: ", GlobalResources.oxygen,"/1000",
	"\nEmergency Oxygen: ",GlobalResources.emergencyFuel, "/100",
	 "\n\nA critical survival resource that determines how long you can explore hazardous or air-limited environments such as space. Oxygen depletes over time, in order to replenish this, you may replenish it in expedition or events in order to avoid suffocation and crew discontent. Manage your oxygen carefully, locate oxygen gas tanks, and plan each cycle to maximize oxygen management.")

func _on_check_spareparts_mouse_entered() -> void:
	$CheckSpareparts/Storage_Spareparts.show()
	$CheckSpareparts/Storage_Spareparts/Spareparts.text =  str("Spare-parts: ", GlobalResources.spareparts,  "\n\nVersatile mechanical components used for repairing damaged equipment, and crafting essential tools. Spare Parts are commonly found but limited in supply, making them valuable for maintaining operational stability.you may replenish it in expedition or events. \nUse Spare Parts to restore functionality to broken devices or in events, or craft new gear, but manage them wisely to ensure you're prepared for unexpected events.")

func _on_checking_medicine_mouse_exited() -> void:
	$CheckingMedicine/Storage_Medicine.hide()

func _on_checking_biogene_mouse_exited() -> void:
	$CheckingBiogene/Storage_Biogene.hide()

func _on_checking_fuel_mouse_exited() -> void:
	$CheckingFuel/Storage_Fuel.hide()

func _on_checking_ration_mouse_exited() -> void:
	$CheckingRation/Storage_Ration.hide()

func _on_checking_oxygen_mouse_exited() -> void:
	$CheckingOxygen/Storage_Oxygen.hide()

func _on_check_spareparts_mouse_exited() -> void:
	$CheckSpareparts/Storage_Spareparts.hide()
