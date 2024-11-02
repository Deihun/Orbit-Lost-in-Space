extends Node2D

#Extensions
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_manager = InteractionManager
@onready var res = GlobalResources

#VARIABLES
var inventory 
var alreadyTrigger : bool = false
var isPlayer_inside : bool = false
var readyToGoInside : bool = false
var charge_SkipTime : float = 0.0
var player 

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
	
	await get_tree().create_timer(0.12).timeout
	if isPlayer_inside == true and Input.is_action_pressed("Interact") and readyToGoInside:
		charge_SkipTime += 0.01
		if charge_SkipTime >= 1.0 and player and !alreadyTrigger:
			alreadyTrigger = true
			player.gameWin()
	else:
		charge_SkipTime -= 0.1 if charge_SkipTime > 0.0 else 0.0

func getIsPlayerInsideCondition() -> bool:
	return $Player_Final_Count._isPlayerInside

func interaction(): #Interaction method for InteractionManagement Class
	var crew_ui = NodeFinder.find_node_by_name(get_tree().current_scene,"Crew_Show")
	$Sprite2D.play("Transfer")
	inventory._insert_all_items()
	res.showTotalItems()
	crew_ui.updateUI()


func _on_skip_timer_body_entered(body: Node2D) -> void:
	if body.name == "Player" or "player":
		isPlayer_inside = true


func _on_skip_timer_body_exited(body: Node2D) -> void:
	if body.name == "Player" or "player":
		isPlayer_inside = false
		readyToGoInside = true
