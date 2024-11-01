extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var res = GlobalResources

#VARIABLES
var inventory 
var alreadyTrigger : bool = false
var isPlayer_inside : bool = false
var charge_SkipTime : float = 0.0
var recentAnimation : String = ""
var player : Node2D

#VOID METHODS
func _ready():	#onStart, Initialize the inventory paths
	
	player = NodeFinder.find_node_by_name(get_tree().current_scene, "Player")
	inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
	set_process(true)
	pass


func _process(delta):
	if not inventory: #This recursion ensure that the pathing is called correctly 
		inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "UI_On_Hand")
	interaction_area.interact = Callable(self,"interaction") #Call Interaction callable for other accessors


func interaction(): #Interaction method for InteractionManagement Class
	if inventory.getUsedSlots() > 0:
		print(inventory.getUsedSlots()," > ",0)
		$InteractionArea/CollisionShape2D.disabled = true
		$RadsCooldown.start()
		$AnimatedSprite2D.stop()
		$RandomAnimation.stop()
		playAnimation("Exit")
		inventory._insert_all_items()
		res.showTotalItems()
	else: 
		var player_cb = NodeFinder.find_node_by_name(get_tree().current_scene, "player")
		var warning = NodeFinder.find_node_by_name(get_tree().current_scene,"FullInventoryIndicator")
		warning.onStart("Give an item to for it to help you transfer items!")

func playAnimation(animation : String):
	recentAnimation = animation
	$AnimatedSprite2D.play(animation)

func _on_timer_timeout() -> void:
	$InteractionArea/CollisionShape2D.disabled = false
	$AnimatedSprite2D.show()
	$RandomAnimation.start()
	playAnimation("Idle")


func _on_animated_sprite_2d_animation_finished() -> void:
	if recentAnimation == "Exit": $AnimatedSprite2D.hide()
	else: playAnimation("Idle")
	


func _on_random_animation_timeout() -> void:
	if $AnimatedSprite2D.visible:
		var aniplay = "Blinking" if 0.5 > randf() else "Bouncing"
		playAnimation(aniplay)
