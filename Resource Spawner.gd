extends Node2D

#EXTENSION PACKAGE SCENE
@export_group("Importable Items")
@export var SmallCanVariety1: PackedScene
@export var SmallCanVariety2: PackedScene
@export var SmallCanVariety3: PackedScene
@export var StackedCan : PackedScene
@export var SmallGasTank: PackedScene
@export var spareparts_variety1: PackedScene
@export var medicinepack : PackedScene
@export var fuel: PackedScene
@export var food: PackedScene
@export var biogene: PackedScene
@export var spareparts: PackedScene
@export var ductapes: PackedScene

@export_group("Crews")
@export var allowCrew_Spawn : bool = false
@export var Fumiko : PackedScene
@export var Nashir : PackedScene
@export var Maxim : PackedScene
@export var Regina : PackedScene

@export_group("Chance or Conditions")
@export var resource_chances := {
	"Food": 0.4,
	"Biogene": 0.55,
	"SpareParts": 0.55,
	"Medicine": 0.12,
	"Oxygen": 0.4,
	"Fuel": 0.4,
	"DuctTape": 0.001
}


@onready var timer = $Timer
#@export var medicine: PackedScene

#VARIABLE
var rng = RandomNumberGenerator.new()
var crew = {
	"regina" : false,
	"fumiko" : false,
	"maxim" : false,
	"nashir" : false
}
@export var number_of_resources = 10



func _ready():	#init array, get all child spawn into array.
	var positions = []
	var guaranteed_resources = [fuel, getSmallCanVariety()] #Make sure fuel and food will spawn 
	var remaining_resources = number_of_resources - guaranteed_resources.size() * 3
	var resources_to_spawn = []

	for child in get_children():
		if child is Node2D:
			child.name = "node_position_spawner_"
			positions.append(child.position)

	number_of_resources = min(number_of_resources, positions.size())

	if allowCrew_Spawn == false:
		crew["regina"] = true
		crew["maxim"] = true
		crew["nashir"] = true
		crew["fumiko"] = true

#	for resource in guaranteed_resources:
#		for i in range(3):
#			resources_to_spawn.append(resource)
#	number_of_resources = min(number_of_resources,positions.size())
#	positions.shuffle()


	for i in range(number_of_resources -1):
		var resource_instance
		var rand = int(randf() * 100)
		if crew["regina"] == false:
			resource_instance = Regina.instantiate()
			crew["regina"] = true
			resource_instance.position = positions[i]
			resource_instance.name = "Regina_"
			add_child(resource_instance)
			continue
		elif crew["maxim"] == false:
			resource_instance = Maxim.instantiate()
			crew["maxim"] = true
			resource_instance.name = "Maxim_"
			resource_instance.position = positions[i]
			add_child(resource_instance)
			continue
		elif crew["nashir"] == false:
			resource_instance = Nashir.instantiate()
			crew["nashir"] = true
			resource_instance.name = "Nashir_"
			resource_instance.position = positions[i]
			add_child(resource_instance)
			continue
		elif crew["fumiko"] == false:
			resource_instance = Fumiko.instantiate()
			crew["fumiko"] = true
			resource_instance.name = "Fumiko_"
			resource_instance.position = positions[i]
			add_child(resource_instance)
			continue


		var total_chance = 0.0
		for chance in resource_chances.values():
			total_chance += chance
		var random_value = randf() * total_chance
		for resource_name in resource_chances.keys():
			random_value -= resource_chances[resource_name]
			if random_value <= 0:
				resource_instance = initiateItem(resource_name)
				break
		
		if resource_instance:
			resource_instance.position = positions[i]
			add_child(resource_instance)



	
	
		#if rand < 3 :
		#	match int(randf()*2):
		#		0:
		#			resource_instance = ductapes.instantiate()
		#		1:
		#			resource_instance = medicinepack.instantiate()
		#elif rand > 1 && rand < 50:
		#	match int(randf() * 3):
		#		0:
		#			resource_instance = fuel.instantiate()
		#			var unique_id = str(rng.randf_range(0, 1000000))
		#			resource_instance.name = "Small Battery" + "_" + unique_id
		#			
		#		1:
		#			resource_instance = getSmallCanVariety()
		#		2:
		#			resource_instance = SmallGasTank.instantiate()
		#else:
		#	match int(randf() * 2):
		#		0: 
		#			match int(randf()*2):
		#				0:
		#					resource_instance = spareparts.instantiate()
		#				1:
		#					resource_instance = spareparts_variety1.instantiate()
		#			
		#		1:
		#			resource_instance = biogene.instantiate()
		#resource_instance.position = positions[i].position
		#add_child(resource_instance)



func initiateItem(item_name : String):
	var resource_instance
	match item_name:
		"Food":
			resource_instance = getSmallCanVariety()
			resource_instance.name = "food_pickup" + str(rng.randi())
			pass
		"Biogene":
			resource_instance = biogene.instantiate()
			resource_instance.name = "biogene_pickup" + str(rng.randi())
			pass 
		"SpareParts": 
			match int(randf()*2):
				0:
					resource_instance = spareparts.instantiate()
					resource_instance.name = "sparepart_pickup" + str(rng.randi())
				1:
					resource_instance = spareparts_variety1.instantiate()
					resource_instance.name = "sparepart_pickup" + str(rng.randi())
			pass
		"Medicine":
			resource_instance = medicinepack.instantiate()
			resource_instance.name = "medicine_pickup" + str(rng.randi())
			pass 
		"Oxygen":
			resource_instance = SmallGasTank.instantiate()
			resource_instance.name = "oxygen_pickup" + str(rng.randi())
			pass 
		"Fuel": 
			resource_instance = fuel.instantiate()
			var unique_id = str(rng.randf_range(0, 1000000))
			resource_instance.name = "Small Battery" + "_" + unique_id
			pass
		"DuctTape":
			resource_instance = ductapes.instantiate()
			resource_instance.name = "ductape_pickup" + str(rng.randi())
			pass 
	return resource_instance




func getSmallCanVariety():
	var resource_instance
	if randf() * 1.0 < 0.05:
		resource_instance = StackedCan.instantiate()
	else:
		var random = int(randf() * 3)
		match random:
			0: resource_instance = SmallCanVariety1.instantiate()
			1: resource_instance = SmallCanVariety2.instantiate()
			2: resource_instance = SmallCanVariety3.instantiate()
	resource_instance.name = "food_pickup" + str(rng.randi())
	return resource_instance


func _on_timer_timeout() -> void:
	pass

func _sort_by_adjusted_y(a,b):
	pass
