extends Sprite2D
@onready var information : NinePatchRect = $NinePatchRect
@onready var container : Control = $Details_Container
@onready var crew_1 : Button = $Crew_toChoose/Crew_1
@onready var crew_2 : Button = $Crew_toChoose/Crew_2
@onready var crew_3 : Button = $Crew_toChoose/Crew_3
@onready var crew_4 : Button = $Crew_toChoose/Crew_4

var selection_ui_position = [Vector2(-761.118,-175),Vector2(-416.14,-175),Vector2(-63.623,-175),Vector2(278.527,-175)]
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
	
	var pos = Vector2(80,900)
	if crew.size() < 1: return
	for child in $Crew_toChoose/Crew_1.get_children():
		child.queue_free()
	var resource = $"../WholeInteriorScene/Lobby".getScene(crew[0])
	resource = resource.instantiate()
	resource.scale = Vector2(0.5,0.5)
	resource.position += pos
	$Crew_toChoose/Crew_1.add_child(resource)

	if crew.size() < 2: return
	for child in $Crew_toChoose/Crew_2.get_children():
		child.queue_free()
	var resource_2 = $"../WholeInteriorScene/Lobby".getScene(crew[1])
	resource_2 = resource_2.instantiate()
	resource_2.scale = Vector2(0.5,0.5)
	resource_2.position += pos
	$Crew_toChoose/Crew_2.add_child(resource_2)

	if crew.size() < 3: return
	for child in $Crew_toChoose/Crew_3.get_children():
		child.queue_free()
	var resource_3 = $"../WholeInteriorScene/Lobby".getScene(crew[2])
	resource_3 = resource_3.instantiate()
	resource_3.scale = Vector2(0.5,0.5)
	resource_3.position += pos
	$Crew_toChoose/Crew_3.add_child(resource_3)

	if crew.size() < 4: return
	for child in $Crew_toChoose/Crew_4.get_children():
		child.queue_free()
	var resource_4 = $"../WholeInteriorScene/Lobby".getScene(crew[3])
	resource_4 = resource_4.instantiate()
	resource_4.scale = Vector2(0.5,0.5)
	resource_4.position += pos
	$Crew_toChoose/Crew_4.add_child(resource_4)



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
			_description = "Maxim is your buff guy, able to carry with additional four slot but he is much slower than your usual."
			pass
		"REGINA":
			_name = "Regina"
			IngameStoredProcessSetting.selectedCrew = "Regina"
			IngameStoredProcessSetting.speed = 50
			IngameStoredProcessSetting.inventory = 4
			IngameStoredProcessSetting.BonusMultiplyer = 2.5
			_description = "Regina, a very cautious biologist when it comes to handling things. She might not be your best bet but she makes sure the items she bring to you are perfectly intacked"
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
			_description = "Fumiko is a very swift optimist girl, able to run around the map much more faster than your average crew"
		"NASHIR":
			_name = "Nashir"
			IngameStoredProcessSetting.selectedCrew = "Nashir"
			IngameStoredProcessSetting.BonusMultiplyer = 1.75
			IngameStoredProcessSetting.speed = 120
			IngameStoredProcessSetting.inventory = 4
			_description = "Nashir can be cautious with handling thing but keep getting distracted by his own 'beauty'"
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
		"Earth2.0":
			description = "A planet that seems to be the final destination, the final hope of humanity. Many embark in this planet, in this galaxy as its satisfied every condition a human life needs."
		"Steelicus":
			description = "An advance planet overule by technoly. Steelicus is a harsh planet with an abundance of elemenets of steel and copper."
		"Sauria":
			description = "A dessert planet where temperature range between 50-80 degree during the day and cool off extremely at night"
	
	$Details_Container/Planet_description_label.text = description
