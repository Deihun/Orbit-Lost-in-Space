extends Camera2D
var adjustingPosition = Vector2( 560 , 590)
var secondsTransition : float = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../tobeRemove".play()
	make_current()
	await get_tree().create_timer(1.2).timeout 
	var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")
	var player_camera = NodeFinder.find_node_by_name(get_tree().current_scene, "PlayerCamera")
	SimpleMovement.MoveObjectSmoothly(self, player_camera.position + adjustingPosition, secondsTransition)
	await get_tree().create_timer(secondsTransition).timeout 
	player_camera.make_current()
	player.gameStart()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
