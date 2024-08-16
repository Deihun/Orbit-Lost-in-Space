extends Control

#EXTENSION VARIABLES
@onready var camera = $cam2d
@onready var buttonUI = $cam2d/Button_navigation_node_parent
@onready var ClickCD = $cam2d/Button_navigation_node_parent/ClickCooldown
@onready var CycleSetting = $"/root/IngameStoredProcessSetting"
@onready var EventHandler = $EventHandler

#VARIABLES
			#Camera Varible
var navigation_score = 0
var canbeClick = true


#VOID METHODS // CAMERA CONTROLS - SETTINGS
func _process(delta):
	if Input.is_key_pressed(KEY_A):
		changetoLeft()
	elif Input.is_key_pressed(KEY_D):
		changetoRight()


func _ready():
	CycleSetting.newGame()
	navigation_score = 1
	EventHandler.startAddNextEvent()
	EventHandler.ActivateEvent()
	change_UI()
	pass 


func _on_texture_button_pressed():
	changetoLeft()

func _on_right_button_ui_pressed():
	changetoRight()


func changetoLeft():
	if canbeClick == true:
		if navigation_score > -1:
			navigation_score -= 1
			change_UI()
			canbeClick = false
			ClickCD.start()


func changetoRight():
	if canbeClick == true:
			if navigation_score < 1:
				navigation_score += 1
				change_UI()
				canbeClick = false
				ClickCD.start()

func change_UI():
	match navigation_score:
		-1:
			
			camera.position = Vector2(-1200,0)
			#buttonUI.position = getButtonPosition()
		0:
			camera.position = Vector2(0,0)
			#buttonUI.position = getButtonPosition()
		1:
			camera.position = Vector2(1200,0)
			#buttonUI.position = getButtonPosition()
		2: 
			camera.position = Vector2(2400,0)
			#buttonUI.position = getButtonPosition()


func getButtonPosition():
	return camera.position + Vector2(-550,100)


func _on_click_cooldown_timeout():
	canbeClick = true


#GAME SETTINGS
func _newGameStart():
	pass

func _loadGameStart(load_json):
	pass


func _on_next_day_button_pressed():
	#Switch to Event View
	navigation_score = 1
	change_UI()
	#Handle Mini Event (PRIORITY 1)
	#Handle UI Cycle
	CycleSetting.endCycle()
	print("Cycle: ",CycleSetting.getCycle())
	#Handle Event
	EventHandler._removeAllEvent()
	EventHandler.startAddNextEvent()
	EventHandler.ActivateEvent()
	
