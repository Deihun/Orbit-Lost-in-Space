extends Sprite2D

#EXTENSION VARIABLES
@onready var interaction_area: InteractionArea = $InteractionArea_inventoryFruit
@onready var interaction_manager = InteractionManager
@onready var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")
@onready var Inventory = NodeFinder.find_node_by_name(get_tree().current_scene,"UI_On_Hand")
#VARIABLES
var readyToPickup : bool = true

#VOID METHODS
func _ready():#Initialize the inventory var
	interaction_area.interact = Callable(self,"interaction")
	await get_tree().create_timer(0.1).timeout
	interaction_area = $InteractionArea_inventoryFruit



func interaction():
	if readyToPickup:
		Inventory.set_max_slots(IngameStoredProcessSetting.inventory + 1)
		$InteractionArea_inventoryFruit/InventoryFruit.disabled = true
		readyToPickup = false
		$AnimatedSprite2D.hide()
		texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/InventoryFruit_withoutFruit.png")
	pass
