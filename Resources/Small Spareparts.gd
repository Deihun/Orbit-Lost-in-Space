extends Node

#EXTENSION VARIABLES
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager

#VARIABLES
var inventory 


#VOID METHODS
func _ready(): #Initialize the inventory var
	inventory = get_node("/root/TestingOnRun/Player/player/AllUIParents/UI_On_Hand")


func _process(delta): #Call the inventory repeatedly until the correct path is detected
	if not inventory:
		inventory = get_node("/root/TestingOnRun/Player/player/AllUIParents/UI_On_Hand")
		if inventory:
			print("Sparepats already initialize")
			set_process(false)
	interaction_area.interact = Callable(self,"interaction") #Callable to make sure interaction methods are able to access by others
	

func interaction():
	if inventory.addItem("Small Spareparts",1):
		inventory.showItem()
		interaction_manager.unregister_area(interaction_area)
		queue_free()
