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
var eventHandler

#VOID METHODS // CAMERA CONTROLS - SETTINGS		
func _process(delta):
	if !eventHandler:
		eventHandler = NodeFinder.find_node_by_name(get_tree().current_scene, "EventHandler")
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
	await get_tree().create_timer(0.05).timeout
	if eventHandler:
		print("it exist")
	eventHandler.Critical_Event = SaveGame.critical
	eventHandler.rawEvent = SaveGame.rawEvent
	eventHandler.alreadyTriggeredEvent = SaveGame.alreadyTriggeredEvent
	eventHandler.eventID = SaveGame.eventID
	
	var test = []
	var abc = test


func GameOver(OtherCommands):
	#INCOMPLETE - THIS METHOD IS FOR ENDING THE GAME
	pass

func _on_next_day_button_pressed():
	var EventHandler = $EventHandler
	if GlobalResources.currentActiveQueue <= 0 and !$EventHandler.visible:
		
		
		#Switch to Event View
		camera.ChangeSpecificScene(4)
		#Handle Mini Event (PRIORITY 1)
		#Handle UI Cycle
		CycleSetting.endCycle()
		print("Cycle: ",CycleSetting.getCycle())
		IngameStoredProcessSetting.move_space()
		$WholeInteriorScene/FactionLabel_willBeRemove.text = str("FactionCurrently: ",IngameStoredProcessSetting.current_Factions)
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


func _on_expedition_button_button_down() -> void:
	camera.ChangeSpecificScene(5)
	camera.ChangeLocaton(false)
	pass # Replace with function body.
