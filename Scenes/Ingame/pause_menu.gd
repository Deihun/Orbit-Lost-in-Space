extends Control

var readyToPause : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	set_process_input(true)
	pass # Replace with function body.

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE) and readyToPause:
		_TOGGLE_ESCAPE()
		readyToPause = false
		$PauseTimer.start()


func _TOGGLE_ESCAPE():
	var Pause_button = NodeFinder.find_node_by_name(get_tree().current_scene, "Pause_Button")
	if !readyToPause:
		return
	if visible:
		RESUME()
	else:
		_pause()


func _pause():
	
	visible = true
	Engine.time_scale = 0
	var TutorialUI = NodeFinder.find_node_by_name(get_tree().current_scene, "TutorialPanel_Folder")
	var Pause_button = NodeFinder.find_node_by_name(get_tree().current_scene, "Pause_Button")
	if Pause_button:
		Pause_button.visible = false
	if TutorialUI:
		TutorialUI.visible = false
	set_process(true)


func RESUME() -> void:
	var TutorialUI = NodeFinder.find_node_by_name(get_tree().current_scene, "TutorialPanel_Folder")
	var Pause_button = NodeFinder.find_node_by_name(get_tree().current_scene, "Pause_Button")
	if Pause_button:
		Pause_button.visible = true
	if TutorialUI:
		TutorialUI.visible = true
	Engine.time_scale = 1
	visible = false
	pass # Replace with function body.


func RESTART() -> void:
	visible = false
	Engine.time_scale = 1
	get_tree().reload_current_scene()



func QUIT() -> void:
	get_tree().quit()


func MAIN_MENU() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
	pass # Replace with function body.


func READY_TO_PAUSE() -> void:
	readyToPause = true
