extends Control

#EXTENSION VARIABLES
@onready var camera = $cam2d
@onready var buttonUI = $cam2d/Button_navigation_node_parent
@onready var ClickCD = $cam2d/Button_navigation_node_parent/ClickCooldown
@onready var CycleSetting = $"/root/IngameStoredProcessSetting"
@onready var EventHandler = $EventHandler
@onready var putResources = GlobalResources
@onready var SaveGame = SaveNLoad
@onready var crafted_items_inventory: Control = $CraftedItemsInventory
@onready var item_ui: Control = NodeFinder.find_node_by_name(get_tree().current_scene, "Item_UI")
@onready var setanimation = NodeFinder.find_node_by_name(get_tree().current_scene, "Craft")

#VARIABLES
var resources 
var events
var gameEndReason = "null"
var EndCycle_Can_Be_Click_ : bool = true
var gameOver : bool = false
#VARIABLE_FUNCTIONS
var ClickTrue = true
var initialEvent = []
var eventHandler 

#VOID METHODS // CAMERA CONTROLS - SETTINGS
func _process(delta):
	if !eventHandler:
		eventHandler = NodeFinder.find_node_by_name(get_tree().current_scene, "EventHandler")
	pass

func _ready():
	$WholeInteriorScene/Lobby.initializeJSONFILE()
	if SaveGame.isLoadGame:
		_loadGameStart()
	else:
		_newGameStart()
	updateUI()

func getButtonPosition():
	return camera.position + Vector2(-550,100)

#GAME SETTINGS
func _newGameStart():
	$WholeInteriorScene/Lobby.Tag.append("FIRSTDAY")
	SaveGame.isLoadGame = true
	CycleSetting.newGame()
	EventHandler.startAddNextEvent()
	EventHandler.ActivateEvent()
	$WholeInteriorScene/Lobby.set_initialDialogue()
	_setUpInitialEvent()


func _setUpInitialEvent()-> void: #ADD INITIAL EVENT HERE
	for b in initialEvent:
		GlobalResources.Priority_Event.append(b)


func removeitOnSecondDay()-> void:
	if IngameStoredProcessSetting.Cycle > 1:
		for b in initialEvent:
			if GlobalResources.Priority_Event.has(b):
				GlobalResources.Priority_Event.erase(b)


func _loadGameStart()-> void:
	updateUI()
	updateCockpit()


func GameOver(Ending : String)-> void: #TriggerEnding
	IngameStoredProcessSetting.Ending = Ending
	get_tree().change_scene_to_file("res://Scenes/EndScenes/EndingScene.tscn")


func _on_next_day_button_pressed():
	if !EndCycle_Can_Be_Click_: return
	var EventHandler = $EventHandler
	EndCycle_Can_Be_Click_ = false

	if GlobalResources.currentActiveQueue <= 0:
		#Handle Mini Event (PRIORITY 1)
		#Handle UI Cycle
		IngameStoredProcessSetting.canExpedition = true
		removeitOnSecondDay()
		CycleSetting.endCycle()
		_is_MainFaction()
		#crafting
		if item_ui.ongoingCraft == true:
			item_ui.ongoingCraft = false
			if item_ui.currentlycrafting == "MedkitCharge" or item_ui.currentlycrafting == "FreDriSpaceFood" or item_ui.currentlycrafting == "DehySpaceFood":
				match item_ui.currentlycrafting:
					"MedkitCharge":
						GlobalResources.AddItem(true, "MEDKIT", 1)
					"FreDriSpaceFood":
						GlobalResources.AddItem(true, "FOOD", 10)
					"DehySpaceFood":
						GlobalResources.AddItem(true, "FOOD", 20)
			else:
				GlobalResources.uniqueItems.append(item_ui.currentlycrafting)
			item_ui.currentlycrafting = ""
			setanimation._ready()
		#Handle Event
		EventHandler._removeAllEvent()
		EventHandler.startAddNextEvent()
		EventHandler.ActivateEvent()
		ClickCD.start()
		$WholeInteriorScene/Lobby.setRandomPosition()
		$WholeInteriorScene/Lobby.set_initialDialogue()
		if checkIfKickoutEnough() : GameOver("Kickout")
		updateUI()
		camera.ChangeSpecificScene(4)
		if gameOver: GameOver(gameEndReason)
	else:
		camera.ChangeSpecificScene(2)


func updateUI():
	$WholeInteriorScene/FactionLabel_willBeRemove.text = str("FactionCurrently: ",IngameStoredProcessSetting.current_Factions)
	$cam2d/Button_navigation_node_parent/MeteorCyce/Cycle_number.text = str(IngameStoredProcessSetting.Cycle)
	if IngameStoredProcessSetting.current_Factions in ["None","Space","Asteroid","Blackhole"] :$WholeInteriorScene/ExpeditionButton.hide()
	elif IngameStoredProcessSetting.canExpedition :$WholeInteriorScene/ExpeditionButton.show()
	updateCockpit()
	_updateUIExpeditionScreen()


func updateCockpit():
	var a = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Space.png")
	match IngameStoredProcessSetting.current_Factions:
		"SPACE":a    = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Space.png")
		"None":a     = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Space.png")
		"Radonti":a  = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Radonti.png")
		"Steelicus":a = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/SteelicusCockpit.png")
		"Earth2.0":a = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Earth2.0Cockpit.png")
		"Sauria":a = load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/SauriaCockpit.png")
		"Enthuli": pass
		"AbandonShip":pass
		_: a=load("res://Scenes/ExpeditionSelection/Expedition_Faction_Game/Space.png")
	$WholeInteriorScene/Cockpit.texture = a


func _on_click_cooldown_timeout() -> void:
	ClickTrue = true

func _is_MainFaction():
	match IngameStoredProcessSetting.current_Factions:
		"Radonti": 
			if IngameStoredProcessSetting.Factions_Probability["Radonti"] > 0.0:
				GlobalResources.Critical_Event.append("Radonti")
		"Sauria": 
			if IngameStoredProcessSetting.Factions_Probability["Sauria"] > 0.0:
				GlobalResources.Critical_Event.append("Sauria")
		"Steelicus": 
			if IngameStoredProcessSetting.Factions_Probability["Steelicus"] > 0.0:
				GlobalResources.Critical_Event.append("Steelicus")
		"Earth2.0": 
			if IngameStoredProcessSetting.Factions_Probability["Earth2.0"] > 0.0:
				GlobalResources.Critical_Event.append("Earth2.0")

func PAUSE() -> void:
	var pause = $PauseMenu
	pause.position = $cam2d.position + Vector2(1584, 350)
	pause._pause()

func _on_expedition_button_button_down() -> void:
	camera.ChangeSpecificScene(5)
	camera.ChangeLocaton(false)

func _on_embark_button_pressed() -> void: #WHEN EMBARK
	match (IngameStoredProcessSetting.current_Factions):
		"AbandonShip":IngameStoredProcessSetting.Scenes = "abandonship"
		"Radonti":IngameStoredProcessSetting.Scenes = "Radonti"
		"Sauria":IngameStoredProcessSetting.Scenes = "Sauria"
		"Earth2.0":IngameStoredProcessSetting.Scenes = "Earth2"
		"Enthuli":IngameStoredProcessSetting.Scenes = "Enthuli"
		"Steelicus":IngameStoredProcessSetting.Scenes = "Steelicus"
	var loadingScreen = preload("res://Scenes/LoadingScene.tscn") as PackedScene
	IngameStoredProcessSetting.canExpedition = false
	get_tree().change_scene_to_packed(loadingScreen)


func _on_crafted_items_ui_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		crafted_items_inventory.show()
		crafted_items_inventory.set_Items()

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


func checkIfKickoutEnough() -> bool:
	var condition = false
	for crew in IngameStoredProcessSetting.crew_in_ship:
		condition = true if IngameStoredProcessSetting._relationship[crew] <= 0.0 else false
	if condition:
		if randf() > 0.25:
			return true
	return false


func _on_fact_button_button_button_up() -> void:
	$cam2d/FactButton.show()
