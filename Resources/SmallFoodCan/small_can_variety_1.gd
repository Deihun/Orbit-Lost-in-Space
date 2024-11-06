extends RigidBody2D

#EXTENSION VARIABLE
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var animationSprite = $AnimatedSprite2D
@onready var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")

#VARIABLE
var inventory 
var is_rolling: bool = false

#VOID METHODS
func _ready():#
	animationSprite = $AnimatedSprite2D
	set_animation()
	inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
	if not inventory: #DEBUG incase path got change or updated
		print("SmallFood: Unable to path UI_ON_HAND")
	set_process(true)


func _process(delta): #Repeatedly set a path until a correct path is detected
	if not inventory: 
		inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
		if inventory:
			print("Fuel Already detected and initialize")
			set_process(false)
	interaction_area.interact = Callable(self,"interaction") #Callable for interaction method to be access
	
	var speed = linear_velocity.length()
	animationSprite.speed_scale = (speed*0.01)
	if is_rolling:
		if speed > 1:
			animationSprite.play("Can_Rolling")
		else:
			animationSprite.stop()
	else:
		animationSprite.play("Can_Standing")


func interaction():
	if inventory.addItem("Small Food",1):
		player.pickup()
		inventory.showItem()
		interaction_manager.unregister_area(interaction_area)
		queue_free()


func set_animation():
	if is_rolling:
		animationSprite.play("Can_Rolling")
	else:
		animationSprite.play("Can_Standing")


func _on_chance_to_roll_area_entered(area: Area2D) -> void:
	print("touchy touchy")
	if randf() < 0.25:
		is_rolling = true
	else:
		is_rolling = false


func WhenTouch(body: Node) -> void:
	print("Touch")


func _on_interaction_area_area_entered(area: Area2D) -> void:
	if randf() < 0.45:
		is_rolling = true
	else:
		is_rolling = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	$Can_kicked.play()
	if randf() < 0.45:
		is_rolling = true
		linear_damp = 1
