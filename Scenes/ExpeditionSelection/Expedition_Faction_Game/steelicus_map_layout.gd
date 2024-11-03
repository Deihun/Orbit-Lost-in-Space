extends Node2D

#NODES
@onready var space_image = $Space
@onready var _player = $Player
@onready var player_cb = $Player/player
@onready var interactionarea1 : InteractionArea = $Keycard1/InteractionArea
@onready var interactionarea2 : InteractionArea = $Keycard2/InteractionArea
@onready var interactionarea3 : InteractionArea = $Keycard3/InteractionArea
@onready var interactionarea4 : InteractionArea = $Keycard4/InteractionArea
#VARIABLE
var crew_name = IngameStoredProcessSetting.selectedCrew
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactionarea1.interact = Callable(self,"keycardInteract1")
	interactionarea2.interact = Callable(self,"keycardInteract2")
	interactionarea3.interact = Callable(self,"keycardInteract3")
	interactionarea4.interact = Callable(self,"keycardInteract4")
	var shader = self.material as ShaderMaterial
	shader.set_shader_parameter("base_color", Color(1, 1, 1, 1))
	shader.set_shader_parameter("light_intensity", 0.7)
	player_cb._set_game_over_action(Callable(self,"gameOver"))
	player_cb._set_game_win_condition(Callable(self,"gameWin"))
	gameStart()

func gameStart():
	player_cb.startUI()
	player_cb.canMove = true
	player_cb.gameStart()
	#_player.with_helmet()

func gameOver():
	_player.transition()
	player_cb.canMove = false
	await get_tree().create_timer(2.5).timeout
	IngameStoredProcessSetting.crew_in_ship.erase(crew_name)
	IngameStoredProcessSetting.Scenes = "interiorscene"
	get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
	pass

func gameWin():
	_player.transition()
	player_cb.canMove = false
	await get_tree().create_timer(2.5).timeout
	IngameStoredProcessSetting.Scenes = "interiorscene"
	get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
func keycardInteract1():
	$Doors/DoorWay1.open_door()
	$Keycard1.queue_free()
func keycardInteract2():
	$Doors/DoorWay2.open_door()
	$Keycard2.queue_free()
func keycardInteract3():
	$Doors/DoorWay3.open_door()
	$Keycard3.queue_free()
func keycardInteract4():
	$Doors/DoorWay4.open_door()
	$Keycard4.queue_free()
