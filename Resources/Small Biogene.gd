extends RigidBody2D

#EXTENSION VARIABLES
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var animation = $AnimatedSprite2D
@onready var timer = $RandomAnimationTimer

@export var brokenBiogene: PackedScene

#VARIABLES
var inventory 
var glass_fragileness = 1

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
	if inventory.addItem("Small Biogene",1):
		inventory.showItem()
		interaction_manager.unregister_area(interaction_area)
		queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	animation.play("Idle")


func _on_random_animation_timer_timeout() -> void:
	timer.wait_time = int(randf() * 8)
	match(int(randf() * 3)):
		1:
			animation.play("Bubbly")
		2: 
			animation.play("Shiny")
	timer.start()


func _on_break_area_entered(area: Area2D) -> void:
	glass_fragileness -= 1
	print(glass_fragileness)
	if glass_fragileness < 0:
		var brokenGlass = brokenBiogene.instantiate()
		brokenGlass.position = position
		get_tree().current_scene.add_child(brokenGlass)
		queue_free()
