extends Node2D

#EXTENSION PACKAGE SCENE
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
@onready var timer = $Timer
#@export var medicine: PackedScene

#VARIABLE
var rng = RandomNumberGenerator.new()
@export var number_of_resources = 10



func _ready():	#init array, get all child spawn into array.
	var positions = []
	for child in get_children():
		if child is Node2D:
			positions.append(child)
	
	var guaranteed_resources = [fuel, getSmallCanVariety()] #Make sure fuel and food will spawn 
	var remaining_resources = number_of_resources - guaranteed_resources.size() * 3
	var resources_to_spawn = []
	
	for resource in guaranteed_resources:
		for i in range(3):
			resources_to_spawn.append(resource)
	
	number_of_resources = min(number_of_resources,positions.size())
	positions.shuffle()
	
	for i in range(number_of_resources):
		var resource_instance
		var rand = int(randf() * 100)
		if rand < 3:
			match int(randf()*2):
				0:
					resource_instance = ductapes.instantiate()
				1:
					resource_instance = medicinepack.instantiate()
		elif rand > 1 && rand < 50:
			match int(randf() * 3):
				0:
					resource_instance = fuel.instantiate()
					var unique_id = str(rng.randf_range(0, 1000000))
					resource_instance.name = "Small Battery" + "_" + unique_id
					
				1:
					resource_instance = getSmallCanVariety()
				2:
					resource_instance = SmallGasTank.instantiate()
		else:
			match int(randf() * 2):
				0: 
					match int(randf()*2):
						0:
							resource_instance = spareparts.instantiate()
						1:
							resource_instance = spareparts_variety1.instantiate()
					
				1:
					resource_instance = biogene.instantiate()
		resource_instance.position = positions[i].position
		add_child(resource_instance)

func getSmallCanVariety():
	if randf() * 1.0 < 0.05:
		return StackedCan.instantiate()
	var random = int(randf() * 3)
	print(random)
	match random:
		0:
			return SmallCanVariety1.instantiate()
		1: 
			return SmallCanVariety2.instantiate()
		2: 
			return SmallCanVariety3.instantiate()
		3:
			return SmallCanVariety1.instantiate()


func _on_timer_timeout() -> void:
	pass

func _sort_by_adjusted_y(a,b):
	pass
