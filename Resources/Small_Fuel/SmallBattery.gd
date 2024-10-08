extends Node2D

#EXTENSION VARIABLES
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var animation_battery = $Battery
@onready var Animation_Lightning = $LightningEffect
@onready var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")

#VARIABLES
var inventory 


#VOID METHODS
func _ready():#Initialize the inventory var
	animation_battery.play("Idle")
	animation_battery.frame = int(randf() * 100)
	inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")


func _process(delta): #Call the inventory repeatedly until the correct path is detected
	if not inventory:
		inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
		if inventory:
			print("Fuel Already detected and initialize")
			set_process(false)
	interaction_area.interact = Callable(self,"interaction") #Callable to make sure interaction methods are able to access by others



func interaction():
	if inventory.addItem("Small Fuel",2):
		player.pickup()
		inventory.showItem()
		interaction_manager.unregister_area(interaction_area)
		queue_free()


func _on_lightning_effect_animation_finished() -> void:
	Animation_Lightning.hide()
	pass # Replace with function body.


func AnimationPlay() -> void:
	if (randf() * 1.0) < 0.15:
		Animation_Lightning.visible = true
		Animation_Lightning.play("Lightning")
	pass # Replace with function body.
