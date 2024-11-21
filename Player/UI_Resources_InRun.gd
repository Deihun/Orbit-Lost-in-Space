extends Node2D

var gas = 0
var ration = 0 
var fuel = 0
var spareparts = 0
var biogene = 0
var ductape = 0
var medicine = 0
var crew_availability = 3

var gathered_gas = 0
var gathered_ration = 0 
var gathered_fuel = 0
var gathered_spareparts = 0
var gathered_biogene = 0
var gathered_ductape = 0
var gathered_medicine = 0

var total_gas = 0
var total_ration = 0 
var total_fuel = 0
var total_spareparts = 0
var total_biogene = 0
var total_ductape = 0
var total_medicine = 0

var toggle_collectedUI : bool = false

var crew ={ 
	"fumiko" = false,
	"maxim" = false,
	"nashir" = false,
	"regina" = false
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.05).timeout
	initializeFindSpawn()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ChangeUI_Preview_Inventory"):
		toggle_collectedUI = !toggle_collectedUI
		$Amount_in_Area.visible = toggle_collectedUI
		$AmountPreview.visible = !toggle_collectedUI





func add_item(item_type):#Use to direct add items, used by other objects such as dropbox to add items
	match(item_type):
		"Small Food":
			ration += int(10 * IngameStoredProcessSetting.BonusMultiplyer)
			gathered_ration +=1
			$AmountPreview/Label_Food.text = str(ration)
			$Amount_in_Area/Label_Food.text = str(gathered_ration,"/",total_ration)
		"Small Fuel":
			fuel += int(13 * IngameStoredProcessSetting.BonusMultiplyer)
			gathered_fuel +=1
			$AmountPreview/Label_Fuel.text = str(fuel)
			$Amount_in_Area/Label_Fuel.text = str(gathered_fuel, "/",total_fuel)
		"Small Spareparts":
			spareparts += int(15 * IngameStoredProcessSetting.BonusMultiplyer)
			gathered_spareparts += 1
			$AmountPreview/Label_Spareparts.text =str(spareparts)
			$Amount_in_Area/Label_Spareparts.text = str(gathered_spareparts,"/",total_spareparts)
		"Small Biogene":
			biogene += int(15 * IngameStoredProcessSetting.BonusMultiplyer)
			gathered_biogene += 1
			$AmountPreview/Label_Biogene.text =str(biogene)
			$Amount_in_Area/Label_Biogene.text = str(gathered_biogene,"/",total_biogene)
		"Medicine Pack":
			medicine += int(1 * IngameStoredProcessSetting.BonusMultiplyer)
			gathered_medicine += 1
			$AmountPreview/Label_Medicine.text =str(medicine)
			$Amount_in_Area/Label_Medicine.text = str(gathered_medicine, "/", total_medicine)
		"Ductape":
			ductape += int(1 * IngameStoredProcessSetting.BonusMultiplyer)
			gathered_ductape +=1
			$AmountPreview/Label_Ductape.text = str(ductape)
			$Amount_in_Area/Label_Ductape.text = str(gathered_ductape,"/",total_ductape)
			
		"Small Gastank":
			gas += int(15 * IngameStoredProcessSetting.BonusMultiplyer)
			gathered_gas +=1
			$AmountPreview/Label_Oxygen.text = str(gas)
			$Amount_in_Area/Label_Oxygen.text = str(gathered_gas,"/",total_gas)
		"Regina":
			if crew["regina"] == false:	crew_availability -= 1
			crew["regina"] = true
			
		"Maxim" : 
			if crew["maxim"] == false:	crew_availability -= 1
			crew["maxim"] = true
		"Nashir" : 
			if crew["nashir"] == false:	crew_availability -= 1
			crew["nashir"] = true
		"Fumiko" :
			if crew["fumiko"] == false:	crew_availability -= 1
			crew["fumiko"] = true



func initializeFindSpawn():
	var spawners = find_all_nodes_with_name_pattern(self.get_tree().root, "Node Resource Spawner")
	process_spawner_children(spawners)
	setTheAmountAvailableUI()

func setTheAmountAvailableUI():
	$AmountPreview/Label_Food.text = str(ration)
	$AmountPreview/Label_Fuel.text = "0"
	$AmountPreview/Label_Spareparts.text =str(spareparts)
	$AmountPreview/Label_Biogene.text =str(biogene)
	$AmountPreview/Label_Medicine.text =str(medicine)
	$AmountPreview/Label_Ductape.text = str(ductape)
	$AmountPreview/Label_Oxygen.text = str(gas)
	$Amount_in_Area/Label_Food.text = str(gathered_ration,"/",total_ration)
	$Amount_in_Area/Label_Fuel.text = str(gathered_fuel, "/",total_fuel)
	$Amount_in_Area/Label_Spareparts.text = str(gathered_spareparts,"/",total_spareparts)
	$Amount_in_Area/Label_Biogene.text = str(gathered_biogene,"/",total_biogene)
	$Amount_in_Area/Label_Medicine.text = str(gathered_medicine, "/", total_medicine)
	$Amount_in_Area/Label_Ductape.text = str(gathered_ductape,"/",total_ductape)
	$Amount_in_Area/Label_Oxygen.text = str(gathered_gas,"/",total_gas)

# Finds all nodes in the scene with the name starting with a specific pattern
func find_all_nodes_with_name_pattern(root: Node, pattern: String) -> Array:
	var results = []
	_find_all_nodes_recursive(root, pattern, results)
	return results

# Helper function for recursive node search
func _find_all_nodes_recursive(node: Node, pattern: String, results: Array) -> void:
	if node.name.begins_with(pattern):
		results.append(node)
	for child in node.get_children():
		if child is Node:
			_find_all_nodes_recursive(child, pattern, results)

# Creates variables based on the found spawners
func create_variables_from_spawners(spawners: Array) -> void:
	var count = 0
	for spawner in spawners:
		var var_name = spawner.name
		if var_name:
			# Ensure unique variable name by appending a count
			var_name = spawner.name + str(count)
			count += 1
		self.set(var_name, spawner)

func process_spawner_children(spawners: Array) -> void:
	for spawner in spawners:
		print("Processing spawner:", spawner.name)
		for child in spawner.get_children():
			if child is Node:
				print("Found child:", child.name)
				# You can handle the child here, e.g., store references or call methods on them
				handle_child(child)

# Example function to handle a single child node
func handle_child(child: Node) -> void:
	if child.name.begins_with("ductape_pickup"): total_ductape +=1
	elif child.name.begins_with("Small Battery_"): total_fuel +=1
	elif child.name.begins_with("food_pickup"): total_ration +=1
	elif child.name.begins_with("biogene_pickup"): total_biogene +=1
	elif child.name.begins_with("sparepart_pickup"): total_spareparts +=1
	elif child.name.begins_with("medicine_pickup"): total_medicine +=1
	elif child.name.begins_with("oxygen_pickup"): total_gas +=1

func halfIt():
	gas = int(gas/2)
	ration = int(ration/2)
	fuel = int(fuel/2)
	spareparts = int(spareparts/2)
	biogene = int(biogene/2)
	ductape = int(ductape/2)
	medicine = int(medicine/2)

func updateGlobalResource():
	var r = GlobalResources
	var b = IngameStoredProcessSetting
	r.ration += ration
	r.fuel += fuel
	r.oxygen += gas
	r.spareparts += spareparts
	r.biogene += biogene
	r.ductape += ductape
	r.medicine += medicine


	if crew["regina"] == true and !b.crew_in_ship.has("Regina"): b.crew_in_ship.append("Regina")
	if crew["maxim"] == true and !b.crew_in_ship.has("Maxim"): b.crew_in_ship.append("Maxim")
	if crew["fumiko"] == true and !b.crew_in_ship.has("Fumiko"): b.crew_in_ship.append("Fumiko")
	if crew["nashir"] == true and !b.crew_in_ship.has("Nashir"): b.crew_in_ship.append("Nashir")
	pass
