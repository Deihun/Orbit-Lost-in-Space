extends Sprite2D
@onready var information : NinePatchRect = $NinePatchRect
@onready var container : Control = $Details_Container
@onready var crew_1 : Button = $Crew_toChoose/Crew_1
@onready var crew_2 : Button = $Crew_toChoose/Crew_2
@onready var crew_3 : Button = $Crew_toChoose/Crew_3
@onready var crew_4 : Button = $Crew_toChoose/Crew_4

var selection_ui_position = [Vector2(-761.118,-420.849),Vector2(-416.14,-408.457),Vector2(-63.623,-404.644),Vector2(278.527,-403.691)]
var selected : int = 0
var crew_button = []
var crew = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crew_button = [crew_1,crew_2,crew_3,crew_4]

func uponCall():
	updateSelectionButton()
	selectionClick(0)
	updateDetailsContainer()
	information.position = ( Vector2(966.596,-470))
	container.position = Vector2(991,-449)
	var a = -16
	for i in 25:
		#a = (a - 0.5) if absf(a) <= 1.5 else 1
		a += 0.2
		information.position += Vector2( a ,0)
		container.position += Vector2(a,0)
		
		await get_tree().create_timer(0.019).timeout

func updateSelectionButton():
	crew = IngameStoredProcessSetting.crew_in_ship.duplicate()
	crew.append("Jerry")
	_on_crew_1_pressed()
	for i in range(len(crew_button)):
		if i < len(crew) and crew[i] != null:
			print("indeed")
			crew_button[i].visible = true
		else:
			crew_button[i].visible = false



func _on_crew_1_pressed() -> void:
	selected = 0
	selectionCrew(crew[0])
	selectionClick(0)
	pass # Replace with function body.


func _on_crew_2_pressed() -> void:
	selected = 1
	selectionCrew(crew[1])
	selectionClick(1)
	pass # Replace with function body.


func _on_crew_3_pressed() -> void:
	selected = 2
	selectionCrew(crew[2])
	selectionClick(2)
	pass # Replace with function body.


func _on_crew_4_pressed() -> void:
	selected = 3
	selectionCrew(crew[3])
	selectionClick(3)
	pass # Replace with function body.

func selectionCrew(value : String):
	var _name = ""
	var _description = ""
	match value.to_upper():
		"MAXIM":
			_name = "Maxim"
			IngameStoredProcessSetting.selectedCrew = "Maxim"
			IngameStoredProcessSetting.speed = -50
			IngameStoredProcessSetting.inventory = 6
			IngameStoredProcessSetting.BonusMultiplyer = 1
			pass
		"REGINA":
			_name = "Regina"
			IngameStoredProcessSetting.selectedCrew = "Regina"
			IngameStoredProcessSetting.speed = 50
			IngameStoredProcessSetting.inventory = 4
			IngameStoredProcessSetting.BonusMultiplyer = 2.5
			pass
		"JERRY":
			IngameStoredProcessSetting.selectedCrew = "Jerry"
			_name = "Jerry"
			_description = "Your standard guy for exploration! Jerry has a standard movement speed, item slot and no bonuses to him"
			pass
		"FUMIKO":
			_name = "Fumiko"
			IngameStoredProcessSetting.selectedCrew = "Fumiko"
			IngameStoredProcessSetting.speed = 200
			IngameStoredProcessSetting.inventory = 4
			IngameStoredProcessSetting.BonusMultiplyer = 1.2
			pass
		"NASHIR":
			_name = "Nashir"
			IngameStoredProcessSetting.selectedCrew = "Nashir"
			IngameStoredProcessSetting.BonusMultiplyer = 1.75
			IngameStoredProcessSetting.speed = 120
			IngameStoredProcessSetting.inventory = 4
			pass
	
	$Details_Container/Crew_name_label.text = _name
	$Details_Container/Description_label.text = _description

func selectionClick(value_code : int):
	$SelectedCrewExpedition.position = selection_ui_position[value_code]

func updateDetailsContainer():
	$Details_Container/Planet_name_label.text = "Target Location: " + IngameStoredProcessSetting.current_Factions
	var description = ""
	match IngameStoredProcessSetting.current_Factions:
		"AbandonShip":
			description = "A mysterious floating object that appears to be an old use ship. You will began questioning who use this ship? Where are they now? Hopefully inside this object you can get something useful out of it."
		"SmallPlanetoid":
			description = "A floating small body that ressembles a planet. This planetoid appears to have a small amount of resources within it."
		"Radonti":
			description = "A cold planet with a lively vegetation, detecting multiple lifeforms. Majority of species ressembles similarity to earth species of genus rattus."
	
	$Details_Container/Planet_description_label.text = description
