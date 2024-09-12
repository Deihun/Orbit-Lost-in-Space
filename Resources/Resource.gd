extends Node2D

#EXTENSION VARIABLE
@onready var interaction_area: InteractionArea = $RigidBody2D/InteractionArea
@onready var interaction_manager = InteractionManager
@onready var sprite = $RigidBody2D/Sprite2D

#TEXTURE VARIABLE
var variety_1 = load("res://Resources/Resource_Images/SmallFood_Unpickup_variety2.png")
var variety_2 = load("res://Resources/Resource_Images/SmallFood_Unpickup_variety3.png")
var variety_3 = load("res://Resources/Resource_Images/SmallFood_Unpickup_variety4.png")
var variety_4 = load("res://Resources/Resource_Images/SmallFood_Unpickup_variety5.png")

#VARIABLE
var inventory 


#VOID METHODS
func _ready():#
	inventory = get_node("/root/TestingOnRun/Player/player/AllUIParents/UI_On_Hand")
	if not inventory: #DEBUG incase path got change or updated
		print("SmallFood: Unable to path UI_ON_HAND")
	set_process(true)
	match int(randf()*4): #Randomize Textures
		0:
			sprite.texture = variety_1
		1:
			sprite.texture = variety_2
		2:
			sprite.texture = variety_3
		3: 
			sprite.texture = variety_4


func _process(delta): #Repeatedly set a path until a correct path is detected
	if not inventory: 
		inventory = get_node("/root/TestingOnRun/Player/player/AllUIParents/UI_On_Hand")
		if inventory:
			print("Fuel Already detected and initialize")
			set_process(false)
	interaction_area.interact = Callable(self,"interaction") #Callable for interaction method to be access


func interaction():
	if inventory.addItem("Small Food",1):
		inventory.showItem()
		interaction_manager.unregister_area(interaction_area)
		queue_free()
