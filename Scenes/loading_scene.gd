extends Node2D
@onready var label_Load = $LoadingPoints
var isComplete: bool = false
var progress = []
var sceneName 
var scene_load_status = 0
var newScene

var _newGameWorld = "res://Player/World.tscn"
var mainmenu = "res://MainMenu/main_menu.tscn"
var _tutorial = "res://Scenes/Tutorial/TutorialScene.tscn"
var _abandonShip = "res://Scenes/ExpeditionSelection/Expedition_Faction_Game/abandon_satelite.tscn"
var interiorScene = "res://Scenes/TestingInteriorScene.tscn"

func _ready() -> void:
	var a = IngameStoredProcessSetting.Scenes
	print(a)
	match (a):
		"newgame":
			$TutorialPanel.show()
			sceneName = _newGameWorld
		"loadgame":
			sceneName = interiorScene
		"tutorial":
			sceneName = _tutorial
		"abandonship":
			sceneName = _abandonShip	
		"interiorscene":
			sceneName = interiorScene
		"mainmenu":
			sceneName = mainmenu
		_:
			sceneName = "res://Player/World.tscn"
	
	$TutorialPanel.Colorrect.visible = false
	$PressAnywhere.disabled = true
	ResourceLoader.load_threaded_request(sceneName)


func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName,progress)
	label_Load.text = str(floor(progress[0]*100), "%")
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		newScene = ResourceLoader.load_threaded_get(sceneName)
		isComplete = true
		$LoadingPoints.hide()
		$TapAnywhere_LoadingScreen_Label.show()
		$PressAnywhere.disabled = false


func _on_press_anywhere_pressed() -> void:
	print("clicking")
	if isComplete:
		get_tree().change_scene_to_packed(newScene)
	pass # Replace with function body.
