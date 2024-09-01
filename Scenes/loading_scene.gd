extends Node2D
@onready var label_Load = $LoadingPoints
var progress = []
var sceneName 
var scene_load_status = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sceneName = "res://Scenes/TestingInteriorScene.tscn"
	ResourceLoader.load_threaded_request(sceneName)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName,progress)
	label_Load.text = str(scene_load_status, "%")
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		get_tree().change_scene_to_packed(newScene)
