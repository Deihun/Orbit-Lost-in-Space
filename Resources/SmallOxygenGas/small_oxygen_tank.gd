extends RigidBody2D

@export var Explosion_Scene: PackedScene

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var animation_gasTank = $AnimatedSprite2D
@onready var player = NodeFinder.find_node_by_name(get_tree().current_scene,"player")
#TEXTURE VARIABLE

#VARIABLE
var inventory 
var isDefect : bool
var HP = 1 

#VOID METHODS
func _ready():#
	if (randf() * 1.0) < 0.25:
		isDefect = true
		animation_gasTank.play("Defect")
	else:
		isDefect = false
		animation_gasTank.play("Non_Defect")
	inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
	if not inventory: #DEBUG incase path got change or updated
		print("SmallFood: Unable to path UI_ON_HAND")
	set_process(true)



func _process(delta): #Repeatedly set a path until a correct path is detected
	if not inventory: 
		inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
		if inventory:
			print("GasTank Already initiated")
			set_process(false)
	interaction_area.interact = Callable(self,"interaction") #Callable for interaction method to be access


func interaction():
	if inventory.addItem("Small Gastank",2):
		player.pickup()
		inventory.showItem()
		interaction_manager.unregister_area(interaction_area)
		queue_free()


func _on_damage_hit_point_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Small Battery") && isDefect:
		var explosion = Explosion_Scene.instantiate()
		explosion.position = position
		get_tree().current_scene.add_child(explosion)
		queue_free()
	pass # Replace with function body.
