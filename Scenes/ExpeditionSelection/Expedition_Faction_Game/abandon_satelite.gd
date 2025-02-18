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
	crew_name = IngameStoredProcessSetting.selectedCrew
	camera.make_current()
	_onStartInitialize()
	player_cb._set_game_over_action(Callable(self,"gameOver"))
	player_cb._set_game_win_condition(Callable(self,"gameWin"))


func _onStartInitialize():
	_randomizeSatelite()


func _randomizeSatelite():
	var randomStart = int(randf() * 4.0) +1
	space_image.rotate(randf() * 1.0)
	match randomStart:
		1:
			space_image.position = $Satelite_1.position
			_player.position = $Satelite_1/player_position.position +  $Satelite_1.position
			$DropBox.position = Vector2(2686,1167)
			pass
		2:
			space_image.position = $Satelite_2.position
			_player.position = $Satelite_2/player_position.position+  $Satelite_2.position
			$DropBox.position = Vector2(12072,270)
			pass
		3:
			space_image.position = $Satelite_3.position
			_player.position = $Satelite_3/player_position.position+  $Satelite_3.position
			$DropBox.position = Vector2(3333,6667)
			pass
		4:
			space_image.position = $Satelite_4.position
			_player.position = $Satelite_4/player_position.position+  $Satelite_4.position
			$DropBox.position = Vector2(12109,6743)
			pass
	print(randomStart)
	_player.gameStart()

func gameStart():
	player_cb.startUI()
	player_cb.canMove = true
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
