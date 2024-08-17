extends Control

#EXTENSION VARIABLES
@onready var camera = $cam2d
@onready var buttonUI = $cam2d/Button_navigation_node_parent
@onready var ClickCD = $cam2d/Button_navigation_node_parent/ClickCooldown
@onready var CycleSetting = $"/root/IngameStoredProcessSetting"
@onready var EventHandler = $EventHandler



#VARIABLES
			#Camera Varible


#VOID METHODS // CAMERA CONTROLS - SETTINGS
func _process(delta):
	pass


func _ready():
	CycleSetting.newGame()
	EventHandler.startAddNextEvent()
	EventHandler.ActivateEvent()
	pass 




func getButtonPosition():
	return camera.position + Vector2(-550,100)




#GAME SETTINGS
func _newGameStart():
	pass

func _loadGameStart(load_json):
	pass


func _on_next_day_button_pressed():
	#Switch to Event View
	camera.ChangeSpecificScene(2)
	#Handle Mini Event (PRIORITY 1)
	#Handle UI Cycle
	CycleSetting.endCycle()
	print("Cycle: ",CycleSetting.getCycle())
	#Handle Event
	EventHandler._removeAllEvent()
	EventHandler.startAddNextEvent()
	EventHandler.ActivateEvent()
	
