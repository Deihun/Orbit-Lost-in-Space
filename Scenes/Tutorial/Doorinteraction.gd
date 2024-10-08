extends Node2D

@onready var interaction_area: InteractionArea = $"../InteractionArea2"
@onready var interaction_manager = InteractionManager
@onready var player = $"../player/player"

var inventory 
#VOID METHODS
func _ready():#Initialize the inventory var
	inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")


func _process(delta):#Call the inventory repeatedly until the correct path is detected
	if not inventory:
		inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
		if inventory:
			set_process(false)
	interaction_area.interact = Callable(self,"interaction") #Callable to make sure interaction methods are able to access by others

func interaction():
	$"..".open_door()
	if $"../InteractionArea2":
		$"../InteractionArea2".process_mode =Node.PROCESS_MODE_DISABLED
	pass
