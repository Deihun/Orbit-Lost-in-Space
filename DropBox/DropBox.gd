extends Node2D

#Extensions
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var res = GlobalResources

#VARIABLES
var inventory 


#VOID METHODS
func _ready():	#onStart, Initialize the inventory paths
	inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
	if not inventory: #Debugging for paths
		print("Unable to detect with dropbox: UI On Hand")
	set_process(true)
	pass


func _process(delta):
	if not inventory: #This recursion ensure that the pathing is called correctly 
		inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
		if inventory: 
			print("Fuel Already detected and initialize")
			set_process(false)  #Stop the recursion at all of this object
	interaction_area.interact = Callable(self,"interaction") #Call Interaction callable for other accessors


func interaction(): #Interaction method for InteractionManagement Class
	inventory._insert_all_items()
	res.showTotalItems()
