extends Sprite2D


#EXTENSION VARIABLES
@onready var interaction_area: InteractionArea = $InteractionArea_speedFruit
@onready var interaction_manager = InteractionManager
@onready var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")
#VARIABLES
var readyToPickup : bool = true

#VOID METHODS
func _ready():#Initialize the inventory var
	interaction_area.interact = Callable(self,"interaction")
	pass



func interaction():
	if readyToPickup:
		player.speedFruit()
		$Cooldown.stop()
		$Cooldown.start()
		$InteractionArea_speedFruit/CollisionShape2D_SpeedFruit.disabled = true
		readyToPickup = false
		$AnimatedSprite2D.hide()
		texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/SpeedFruit_withoutfruit.png")
	pass



func _on_cooldown_timeout() -> void:
	readyToPickup = true
	$InteractionArea_speedFruit/CollisionShape2D_SpeedFruit.disabled = false
	texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/SpeedFruit_withfruit.png")
	pass # Replace with function body.
