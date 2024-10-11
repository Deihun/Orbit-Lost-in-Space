extends Sprite2D


func _on_checking_medicine_mouse_entered() -> void:
	$CheckingMedicine/Medicine.visible = true
	$CheckingMedicine/Medicine.text = str("Medicine: ", GlobalResources.medicine)
	
	pass # Replace with function body.


func _on_checking_medicine_mouse_exited() -> void:
	$CheckingMedicine/Medicine.visible = false
	pass # Replace with function body.


func _on_checking_biogene_mouse_entered() -> void:
	$CheckingBiogene/Biogene.visible = true
	$CheckingBiogene/Biogene.text = str("Biogene: ", GlobalResources.biogene)
	
	pass # Replace with function body.


func _on_checking_biogene_mouse_exited() -> void:
	$CheckingBiogene/Biogene.visible = false
	pass # Replace with function body.


func _on_checking_ration_mouse_entered() -> void:
	$CheckingRation/Ration.visible = true
	$CheckingRation/Ration.text = str("FoodRation: ", GlobalResources.ration)
	pass # Replace with function body.


func _on_checking_fuel_mouse_entered() -> void:
	$CheckingFuel/Fuel.visible = true
	$CheckingFuel/Fuel.text = str("Fuel: ", GlobalResources.fuel)
	pass # Replace with function body.


func _on_checking_fuel_mouse_exited() -> void:
	$CheckingFuel/Fuel.visible = false
	pass # Replace with function body.


func _on_checking_ration_mouse_exited() -> void:
	$CheckingRation/Ration.visible = false
	pass # Replace with function body.


func _on_checking_oxygen_mouse_entered() -> void:
	$CheckingOxygen/Oxygen.visible = true
	$CheckingOxygen/Oxygen.text = str("Oxygen: ", GlobalResources.oxygen)


func _on_checking_oxygen_mouse_exited() -> void:
	$CheckingOxygen/Oxygen.visible = false
