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
	print("LIST OF CREW", IngameStoredProcessSetting.crew_in_ship)
	if SaveGame.isLoadGame:
		_loadGameStart()
	else:
		_newGameStart()
	updateUI()

func getButtonPosition():
	return camera.position + Vector2(-550,100)

#GAME SETTINGS
func _newGameStart():
	CycleSetting.newGame()
	EventHandler.startAddNextEvent()
	EventHandler.ActivateEvent()
	pass

func _loadGameStart():
	pass

	
func GameOver(OtherCommands):
	#INCOMPLETE - THIS METHOD IS FOR ENDING THE GAME
	pass

func _on_next_day_button_pressed():
	var EventHandler = $EventHandler
	if GlobalResources.currentActiveQueue <= 0 and !$EventHandler.visible:
		GlobalResources.subtractItem(true, "OXYGEN", 10)
		GlobalResources.subtractItem(true, "FUEL", 10)
		
		
		$WholeInteriorScene/Lobby.setRandomPosition()
		#Switch to Event View
		camera.ChangeSpecificScene(4)
		#Handle Mini Event (PRIORITY 1)
		#Handle UI Cycle
		CycleSetting.endCycle()
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
		
		updateUI()
		
	else:
		camera.ChangeSpecificScene(2)


func updateUI():
	$WholeInteriorScene/FactionLabel_willBeRemove.text = str("FactionCurrently: ",IngameStoredProcessSetting.current_Factions)
	$cam2d/Button_navigation_node_parent/MeteorCyce/Cycle_number.text = str(IngameStoredProcessSetting.Cycle)
	if IngameStoredProcessSetting.current_Factions == "None":$WholeInteriorScene/ExpeditionButton.hide()
	else:$WholeInteriorScene/ExpeditionButton.show()


func _on_click_cooldown_timeout() -> void:
	ClickTrue = true


func PAUSE() -> void:
	var pause = $PauseMenu
	pause.position = $cam2d.position + Vector2(-500, -350)
	pause._pause()
	pass # Replace with function body.


func _on_expedition_button_button_down() -> void:
	camera.ChangeSpecificScene(5)
	camera.ChangeLocaton(false)
	pass # Replace with function body.


func _on_embark_button_pressed() -> void: #WHEN EMBARK
	print(IngameStoredProcessSetting.current_Factions, " = Abandon Ship")
	match (IngameStoredProcessSetting.current_Factions):
		"AbandonShip":
			IngameStoredProcessSetting.Scenes = "abandonship"
			pass
	var loadingScreen = preload("res://Scenes/LoadingScene.tscn") as PackedScene
	get_tree().change_scene_to_packed(loadingScreen)
	pass # Replace with function body.
