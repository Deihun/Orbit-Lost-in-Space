extends Control

#EXTENSION VARIABLES
@onready var camera = $cam2d
@onready var buttonUI = $cam2d/Button_navigation_node_parent
@onready var ClickCD = $cam2d/Button_navigation_node_parent/ClickCooldown
@onready var CycleSetting = $"/root/IngameStoredProcessSetting"
@onready var EventHandler = $EventHandler
@onready var craftingtab = $CraftingTab
@onready var putResources = $"/root/GlobalResources"

#VARIABLES
var ClickTrue = true

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


func GameOver(OtherCommands):
	#INCOMPLETE - THIS METHOD IS FOR ENDING THE GAME
	pass


func _on_next_day_button_pressed():
	var EventHandler = $EventHandler
	print(EventHandler.eventID.size()," CONDITIONS: ",  EventHandler.eventID.size() < 0)
	if EventHandler.isEventVisible != true:
		#Switch to Event View
		camera.ChangeSpecificScene(4)
		#Handle Mini Event (PRIORITY 1)
		#Handle UI Cycle
		CycleSetting.endCycle()
		print("Cycle: ",CycleSetting.getCycle())
		#crafting
		craftingtab.ongoingCraft = false
		putResources.uniqueItems.append(craftingtab.currentlycrafting)
		#Handle Event
		EventHandler._removeAllEvent()
		EventHandler.startAddNextEvent()
		EventHandler.ActivateEvent()
		ClickCD.start()
	else:
		camera.ChangeSpecificScene(2)
		
func _on_click_cooldown_timeout() -> void:
	ClickTrue = true
