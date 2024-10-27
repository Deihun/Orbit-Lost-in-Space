extends Camera2D
@export var adjustingPosition = Vector2( 75 , 230)

@onready var player_cb : CharacterBody2D = $"../Player/player"
@onready var player_position
@onready var player_camera
var secondsTransition : float = 4

# Called when the node enters the scene tree for thefirst time.
func _ready() -> void:
	player_position = NodeFinder.find_node_by_name(get_tree().current_scene, "Player")
	player_camera = NodeFinder.find_node_by_name(get_tree().current_scene, "PlayerCamera")

	player_cb._set_game_over_action(Callable(self,"gameOver"))
	player_cb._set_game_win_condition(Callable(self,"gameWin"))

	gameStart()
func gameOver() -> void:
	player_cb.retry()



func gameWin() -> void:
	var transition = get_parent().get_node("Player/player/AllUIParents/BlackTransition")
	
	player_cb.canMove = false
	player_cb.hideallUI()
	if player_cb.endAnimationOnce:
		transition.show()
		transition.play("default")
		transition.visible = true
		player_cb.endAnimationOnce = false
	await get_tree().create_timer(5).timeout 
	transition.hide()
	var introCam = NodeFinder.find_node_by_name(get_tree().current_scene, "IntroductionCamera")
	if introCam:
		introCam.position = Vector2(4000,-3800)
		introCam.make_current()
	$"../RocketLaunchCutscene".play()
	await get_tree().create_timer(2.5).timeout 
	IngameStoredProcessSetting.Scenes = "interiorscene"
	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
	pass

func gameStart():
	make_current()
	if IngameStoredProcessSetting.is_previous_restart:
		IngameStoredProcessSetting.is_previous_restart = false
		await get_tree().create_timer(0.5).timeout
		await SimpleMovement.MoveObjectSmoothly(self, player_position.position + adjustingPosition, 1.5)
		await get_tree().create_timer(1.5).timeout
	else:
		await get_tree().create_timer(1.2).timeout  
		await SimpleMovement.MoveObjectSmoothly(self, player_position.position + adjustingPosition, secondsTransition)
		await get_tree().create_timer(secondsTransition).timeout


	player_camera.make_current()
	player_cb.startUI()
	player_cb.canMove = true
