extends Node2D
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
var inventory 


func _ready():
	inventory = get_node("../Player/player/Camera2D/UI_On_Hand")
	if not inventory:
		print("unable to detect apple")
	interaction_area.interact = Callable(self,"interaction")
	pass


func _process(delta):
	pass


func interaction():
	if inventory.addItem("Apple",1):
		inventory.showItem()
		interaction_manager.unregister_area(interaction_area)
		queue_free()





