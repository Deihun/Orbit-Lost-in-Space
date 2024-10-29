extends Control

#EXTENSION VARIABLES
@onready var camera = $cam2d
@onready var buttonUI = $cam2d/Button_navigation_node_parent
@onready var ClickCD = $cam2d/Button_navigation_node_parent/ClickCooldown
@onready var CycleSetting = $"/root/IngameStoredProcessSetting"
@onready var EventHandler = $EventHandler
@onready var craftingtab = ItemUi
@onready var putResources = $"/root/GlobalResources"
@onready var SaveGame = SaveNLoad
@onready var crafted_items_inventory: Control = $CraftedItemsInventory

#VARIABLES
var resources 
var events
var EndCycle_Can_Be_Click_ : bool = true
#VARIABLE_FUNCTIONS
var ClickTrue = true
var eventHandler

#VOID METHODS // CAMERA CONTROLS - SETTINGS
func _process(delta):
	if !eventHandler:
		eventHandler = NodeFinder.find_node_by_name(get_tree().current_scene, "EventHandler")
	pass

func _ready():
	$WholeInteriorScene/Lobby.initializeJSONFILE()
	$WholeInteriorScene/Lobby.Tag.append("FIRSTDAY")
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
	$WholeInteriorScene/Lobby.set_initialDialogue()
	pass

func _loadGameStart():
	pass

	
func GameOver(OtherCommands):
	#INCOMPLETE - THIS METHOD IS FOR ENDING THE GAME
	pass

func _on_next_day_button_pressed():
	if !EndCycle_Can_Be_Click_: return
	var EventHandler = $EventHandler
	EndCycle_Can_Be_Click_ = false
	if GlobalResources.currentActiveQueue <= 0:
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
		$WholeInteriorScene/Lobby.setRandomPosition()
		$WholeInteriorScene/Lobby.set_initialDialogue()
		updateUI()
		camera.ChangeSpecificScene(4)
		
	else:
		camera.ChangeSpecificScene(2)


func updateUI():
	$WholeInteriorScene/FactionLabel_willBeRemove.text = str("FactionCurrently: ",IngameStoredProcessSetting.current_Factions)
	$cam2d/Button_navigation_node_parent/MeteorCyce/Cycle_number.text = str(IngameStoredProcessSetting.Cycle)
	if IngameStoredProcessSetting.current_Factions == "SPACE" or IngameStoredProcessSetting.current_Factions == "None":$WholeInteriorScene/ExpeditionButton.hide()
	else:$WholeInteriorScene/ExpeditionButton.show()
	updateCockpit()
	_updateUIExpeditionScreen()


func updateCockpit():
	var a = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Space.png")
	match IngameStoredProcessSetting.current_Factions:
		"SPACE":
			a = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Space.png")
			
		"None":
			a = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Space.png")
			pass
		"Radonti":
			a = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Radonti.png")
			
		"Abandonship":
			pass
	$WholeInteriorScene/Cockpit.texture = a


func _on_click_cooldown_timeout() -> void:
	ClickTrue = true


func PAUSE() -> void:
	var pause = $PauseMenu
	pause.position = $cam2d.position + Vector2(1584, 231)
	pause._pause()

func _on_expedition_button_button_down() -> void:
	camera.ChangeSpecificScene(5)
	camera.ChangeLocaton(false)

func _on_embark_button_pressed() -> void: #WHEN EMBARK
	match (IngameStoredProcessSetting.current_Factions):
		"AbandonShip":
			IngameStoredProcessSetting.Scenes = "abandonship"
			pass
	var loadingScreen = preload("res://Scenes/LoadingScene.tscn") as PackedScene
	get_tree().change_scene_to_packed(loadingScreen)


func _on_crafted_items_ui_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		crafted_items_inventory.show()

func _updateUIExpeditionScreen():
	var expScreen = $WholeInteriorScene/Cockpit/ExpeditionScreen
	if IngameStoredProcessSetting.current_Factions == "None" or IngameStoredProcessSetting.current_Factions == "SPACE":
		expScreen.play("Space")
	elif "AbandonShip":
		expScreen.play("abandonship")


func _on_cancel_button_button_up() -> void:
	$cam2d.ChangeSpecificScene(2)
	$cam2d.ChangeLocaton(false)
	pass # Replace with function body.
