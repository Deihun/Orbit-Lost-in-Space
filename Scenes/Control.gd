extends Control

#EXTENSION VARIABLES
@onready var camera = $cam2d
@onready var buttonUI = $cam2d/Button_navigation_node_parent
@onready var ClickCD = $cam2d/Button_navigation_node_parent/ClickCooldown
@onready var CycleSetting = $"/root/IngameStoredProcessSetting"
@onready var EventHandler = $EventHandler
@onready var craftingtab = $CraftingTab
@onready var putResources = $"/root/GlobalResources"
@onready var SaveGame = SaveNLoad


#VARIABLES
var resources 
var events
#VARIABLE_FUNCTIONS
var ClickTrue = true

#VOID METHODS // CAMERA CONTROLS - SETTINGS		
func _process(delta):
	pass

func _ready():
	CycleSetting.newGame()
	EventHandler.startAddNextEvent()
	EventHandler.ActivateEvent()
	if SaveGame.isLoadGame:
		_loadGameStart()
	else:
		_newGameStart()

func getButtonPosition():
	return camera.position + Vector2(-550,100)

#GAME SETTINGS
func _newGameStart():
	pass

func _loadGameStart():
	SaveGame.load()
	resources = SaveGame.resources
	events = SaveGame.events

func GameOver(OtherCommands):
	#INCOMPLETE - THIS METHOD IS FOR ENDING THE GAME
	pass

func _on_next_day_button_pressed():
	var EventHandler = $EventHandler
	if EventHandler.currentActiveQueue <= 0 and !$EventHandler.visible:
		#DELETE THIS TAB LATER, FOR TESTING PURPOSES
		print("ADDING FUEL")
		GlobalResources.subtractItem(true,"FUEL",10)
		print("ADDING OXYGEN")
		GlobalResources.subtractItem(true, "OXYGEN", 25)
		print("ADDING SPAREPARTS")
		GlobalResources.subtractItem(true, "SPAREPARTS", 25)
		
		
		#Switch to Event View
		camera.ChangeSpecificScene(4)
		#Handle Mini Event (PRIORITY 1)
		#Handle UI Cycle
		CycleSetting.endCycle()
		print("Cycle: ",CycleSetting.getCycle())
		#Auto Save
		SaveGame.save()
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


func PAUSE() -> void:
	var pause = $cam2d/PauseMenu
	pause._pause()
	pass # Replace with function body.
