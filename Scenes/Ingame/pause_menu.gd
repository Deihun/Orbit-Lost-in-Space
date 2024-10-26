extends Control

@onready var save_ui = $ColorRect/SaveUI
@onready var v_box_container: VBoxContainer = $ColorRect/VBoxContainer
@onready var settings_menu = $ColorRect/NinePatchRect2

var readyToPause : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	save_ui.visible = false
	set_process_input(true)

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE) and readyToPause:
		_TOGGLE_ESCAPE()
		readyToPause = false
		$ColorRect/PauseTimer.start()


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

func RESTART() -> void:
	$ColorRect/Restart.show()
	$ColorRect/VBoxContainer.hide()

func QUIT() -> void:
	get_tree().quit()

func MAIN_MENU() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
	

func READY_TO_PAUSE() -> void:
	readyToPause = true

func _on_save_pressed() -> void:
	if save_ui.visible == true:
		save_ui.visible = false
	else:
		save_ui.visible = true
		v_box_container.visible = false


func _on_settings_pressed() -> void:
	settings_menu.visible = true
	$ColorRect/NinePatchRect2/Settings_Menu.show()
	settings_menu.set_process(true)


func _on_settings_menu_visibility_changed() -> void:
	if $ColorRect/NinePatchRect2/Settings_Menu.visible == false:
		$ColorRect/NinePatchRect2.hide()
	pass # Replace with function body.



#RESTART CONFIRMATION
func _on_yes_button_up() -> void:
	Engine.time_scale = 1
	IngameStoredProcessSetting.is_previous_restart = true
	IngameStoredProcessSetting.Scenes = "newgame"
	get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
	pass # Replace with function body.


func _on_no_button_down() -> void:
	$ColorRect/Restart.hide()
	$ColorRect/VBoxContainer.show()
