extends Node2D
@onready var label_Load = $LoadingPoints
var isComplete: bool = false
var progress = []
var sceneName 
var scene_load_status = 0
var newScene



func _ready() -> void:
	$TutorialPanel.Colorrect.visible = false
	$PressAnywhere.disabled = true
	sceneName = "res://Scenes/Ingame/Ingame_Start.tscn"
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
