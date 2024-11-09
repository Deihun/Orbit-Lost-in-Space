extends Node2D



#NODES
@onready var space_image = $Space
@onready var _player = $Player
@onready var player_cb = $Player/player
@onready var camera = $Player/player/PlayerCamera
#VARIABLE
var crew_name = IngameStoredProcessSetting.selectedCrew
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shader = self.material as ShaderMaterial
	shader.set_shader_parameter("base_color", Color(1, 1, 1, 1))
	shader.set_shader_parameter("light_intensity", 0.85)
	player_cb._set_game_over_action(Callable(self,"gameOver"))
	player_cb._set_game_win_condition(Callable(self,"gameWin"))
	gameStart()

func gameStart():
	camera.zoom = Vector2(0.75,0.75)
	player_cb.startUI()
	player_cb.canMove = true
	player_cb.gameStart()
	#_player.with_helmet()

func gameOver():
	_player.transition()
	player_cb.canMove = false
	await get_tree().create_timer(2.5).timeout
	var message = " didn't make it during previous expedition. Becareful when bringing other crew in expedition as losing will cause a lost of selected crew if not Jerry"
	
	if crew_name == "Jerry" and IngameStoredProcessSetting.crew_in_ship.size() > 0:
		IngameStoredProcessSetting.didJerryLose = true
		IngameStoredProcessSetting.Scenes = "interiorscene"
		IngameStoredProcessSetting.deathMessage = "Your crew found you lying in the ground unconscious during your expedition"
		get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
	elif crew_name == "Jerry" and IngameStoredProcessSetting.crew_in_ship.size() <= 0:
		IngameStoredProcessSetting.Ending = "JerryDeath"
		get_tree().change_scene_to_file("res://Scenes/EndScenes/EndingScene.tscn")
	else:
		IngameStoredProcessSetting.deathMessage = crew_name + message
		IngameStoredProcessSetting.crew_in_ship.erase(crew_name)
		IngameStoredProcessSetting.Scenes = "interiorscene"
		get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")

func gameWin():
	var r = NodeFinder.find_node_by_name(get_tree().current_scene, "ResourceUI_InRun")
	r.updateGlobalResource()
	_player.transition()
	player_cb.canMove = false
	await get_tree().create_timer(2.5).timeout
	IngameStoredProcessSetting.Scenes = "interiorscene"
	get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
