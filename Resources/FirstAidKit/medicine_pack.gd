extends RigidBody2D

#EXTENSION VARIABLES
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
#VARIABLES
var inventory 

#VOID METHODS
func _ready():#Initialize the inventory var
	inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")


func _process(delta):#Call the inventory repeatedly until the correct path is detected
	if not inventory:
		inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
		if inventory:
			print("Small Biogene already initialize")
			set_process(false)
	interaction_area.interact = Callable(self,"interaction") #Callable to make sure interaction methods are able to access by others


func interaction():
	if inventory.addItem("Medicine Pack",1):
		inventory.showItem()
		interaction_manager.unregister_area(interaction_area)
		queue_free()
