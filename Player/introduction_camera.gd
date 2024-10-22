extends Camera2D
@export var adjustingPosition = Vector2( 75 , 230)
var secondsTransition : float = 4

# Called when the node enters the scene tree for thefirst time.
func _ready() -> void:
	var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")
	var player_position = NodeFinder.find_node_by_name(get_tree().current_scene, "Player")
	var player_camera = NodeFinder.find_node_by_name(get_tree().current_scene, "PlayerCamera")

	make_current()
	await get_tree().create_timer(1.2).timeout  
	await SimpleMovement.MoveObjectSmoothly(self, player_position.position + adjustingPosition, secondsTransition)
	player.gameStart()
