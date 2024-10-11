extends Node2D

#EXTENSION PACKAGE SCENE
@export var Paper: PackedScene
@export var amount: int = 10
@export var minimum_x : float 
@export var minimum_y : float 
@export var maximum_x : float 
@export var maximum_y : float 

#VARIABLE
var rng = RandomNumberGenerator.new()
@export var number_of_resources = 10



func _ready():	#init array, get all child spawn into array.
	for i in range(amount):
		var random_position = Vector2(randf_range(minimum_x, maximum_x),randf_range(minimum_y, maximum_y))
		var instance = Paper.instantiate()
		instance.position = random_position
		add_child(instance)
