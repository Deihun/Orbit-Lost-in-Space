extends Node2D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var res = GlobalResources
var inventory 


func _ready():
	inventory = get_node("../UI_On_Hand")
	if not inventory:
		print("unable to detect")
	interaction_area.interact = Callable(self,"interaction")
	pass


func _process(delta):
	pass


func interaction():
	inventory._insert_all_items()
	res.showTotalItems()

