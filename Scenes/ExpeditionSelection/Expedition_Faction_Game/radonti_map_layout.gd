extends Node2D


#NODES
@onready var space_image = $Space
@onready var _player = $Player
@onready var player_cb = $Player/player
#VARIABLE
var crew_name = IngameStoredProcessSetting.selectedCrew
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_cb._set_game_over_action(Callable(self,"gameOver"))
	player_cb._set_game_win_condition(Callable(self,"gameWin"))
	var shader = $".".material as ShaderMaterial
	shader.set_shader_parameter("base_color", Color(1, 1, 1, 1))
	shader.set_shader_parameter("light_intensity", 0.95)
	gameStart()



func gameStart():
	player_cb.gameStart()
	player_cb.startUI()
	player_cb.canMove = true
	#_player.with_helmet()

func gameOver():
	gameWin()


func gameWin():
	var r = NodeFinder.find_node_by_name(get_tree().current_scene, "ResourceUI_InRun")
	r.updateGlobalResource()
	_player.transition()
	player_cb.canMove = false
	await get_tree().create_timer(2.5).timeout
	IngameStoredProcessSetting.Scenes = "interiorscene"
	get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
