extends Control

var readyToPause : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	pass # Replace with function body.

func _TOGGLE_ESCAPE():
	if !readyToPause:
		return
	if visible:
		visible = false
		Engine.time_scale = 1
	else:
		visible = true
		Engine.time_scale = 0
	$PauseTimer.start()
	readyToPause = false

func _pause():
	visible = true
	Engine.time_scale = 0
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		_TOGGLE_ESCAPE()
	pass


func RESUME() -> void:
	print("TESTING???")
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
