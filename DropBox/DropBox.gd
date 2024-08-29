extends Node2D

#Extensions
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var res = GlobalResources

#VARIABLES
var inventory 


#VOID METHODS
func _ready():	#onStart, Initialize the inventory paths
	inventory = get_node("root/TestingOnRun/player/player/Camera2D/UI_On_Hand")
	if not inventory: #Debugging for paths
		print("Unable to detect with dropbox: UI On Hand")
	set_process(true)
	pass


func _process(delta):
	if not inventory: #This recursion ensure that the pathing is called correctly 
		inventory = get_node("/root/TestingOnRun/Player/player/Camera2D/UI_On_Hand")
		if inventory: 
			print("Fuel Already detected and initialize")
			set_process(false)  #Stop the recursion at all of this object
	interaction_area.interact = Callable(self,"interaction") #Call Interaction callable for other accessors


func interaction(): #Interaction method for InteractionManagement Class
	inventory._insert_all_items()
	res.showTotalItems()
