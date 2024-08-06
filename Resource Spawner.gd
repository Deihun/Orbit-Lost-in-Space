extends Node2D

#EXTENSION PACKAGE SCENE
@export var fuel: PackedScene
@export var food: PackedScene
@export var biogene: PackedScene
@export var spareparts: PackedScene
@export var ductapes: PackedScene
#@export var medicine: PackedScene

#VARIABLE
@export var number_of_resources = 10


func _ready():	#init array, get all child spawn into array.
	var positions = []
	for child in get_children():
		if child is Node2D:
			positions.append(child)
	
	var guaranteed_resources = [fuel, food] #Make sure fuel and food will spawn 
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
		if rand < 1:
			print("GetDuctape")
			resource_instance = fuel.instantiate()
		elif rand > 1 && rand < 50:
			match int(randf() * 2):
				0:
					resource_instance = fuel.instantiate()
				1:
					resource_instance = food.instantiate()
		else:
			match int(randf() * 2):
				0: 
					resource_instance = spareparts.instantiate()
				1:
					resource_instance = biogene.instantiate()
		resource_instance.position = positions[i].position
		add_child(resource_instance)



