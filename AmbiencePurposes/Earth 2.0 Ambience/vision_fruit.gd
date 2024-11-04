extends Sprite2D


#EXTENSION VARIABLES
@onready var interaction_area: InteractionArea = $InteractionArea_vision
@onready var interaction_manager = InteractionManager
@onready var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")
@onready var camera : Camera2D = NodeFinder.find_node_by_name(get_tree().current_scene, "PlayerCamera")
#VARIABLES
var readyToPickup : bool = true

#VOID METHODS
func _ready():#Initialize the inventory var
	interaction_area.interact = Callable(self,"interaction")
	pass



func interaction():
	if readyToPickup:
		$Cooldown.stop()
		$Cooldown.start()
		#$InteractionArea_vision/CollisionShape2D_visionFruit.disabled = true
		readyToPickup = false
		$AnimatedSprite2D.hide()
		texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/VisionFruit_withoutVisionFruit.png")
		camera.zoom = Vector2(0.52,0.52)
		$Duration.start()
	pass



func _on_cooldown_timeout() -> void:
	$AnimatedSprite2D.show()
	readyToPickup = true
	texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/VisionFruit_withFruit.png")
	pass # Replace with function body.


func _on_duration_timeout() -> void:
	camera.zoom = Vector2(0.75,0.75)
	pass # Replace with function body.
