extends Camera2D

@onready var ArrowButton = [$Button_navigation_node_parent/LeftButton_UI,$Button_navigation_node_parent/RightButton_UI]
@onready var ObjectLeft = Node2D
@onready var EndButton = $Button_navigation_node_parent/EndCycle
@onready var EventUI = get_parent().get_node("EventHandler")
@onready var SpecificLocation = [Vector2(-3100,0),Vector2(-100,0),Vector2(2950,0), Vector2(-3000,1500), Vector2(-3000,3000), $"../ExpeditionSelection".position]

var tween = create_tween()
var nonCommonPanningRooms = [Vector2(-3000,1500), Vector2(-3000,3000)]

var EventTutorial : bool = true
var LocationKey = 1
var canBeClick = true

@onready var ClickCD = $Button_navigation_node_parent/ClickCooldown

func _ready() -> void:
	var parent = get_parent()
	ObjectLeft = parent.get_node("OnCameraMovingDesign/Left_Groups_of_Objects")
	ChangeLocaton(false)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_A):
		ChangeLocationToLeft()
	elif Input.is_key_pressed(KEY_D):
		ChangeLocationToRight()


func ChangeLocationToLeft():
	$"..".EndCycle_Can_Be_Click_ = false
	if canBeClick == true:
		if LocationKey > 0 and LocationKey < 3:
			canBeClick = false
			LocationKey -= 1
			EndButton.disable()
			ChangeLocaton(true)
			ClickCD.start()

func ChangeLocationToRight():
	$"..".EndCycle_Can_Be_Click_ = false
	if canBeClick == true:
		if LocationKey < 2 and LocationKey > -1:
			canBeClick = false
			LocationKey += 1
			EndButton.disable()
			ChangeLocaton(true)
			ClickCD.start()

func ChangeLocaton(smoothMovement:bool):
	$Button_navigation_node_parent/EventSprite_NotifyerUI.visible = false
	$Button_navigation_node_parent/MeteorCyce.hide()
	EndButton.visible = true
	match(LocationKey):
		0:#CraftingRoom
			if GlobalResources.currentActiveQueue > 0:
				$"../EventHandler".isEventVisible = false
				$"../EventHandler".switchIt(false)
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
				MoveObjectSmoothly(ObjectLeft,Vector2(-1500,-600),1.5)
			else:
				tween.kill()
				self.position = SpecificLocation[LocationKey]
			$Button_navigation_node_parent/MeteorCyce.hide()
			EndButton.enable()
			$Button_navigation_node_parent/MeteorCyce.show()
			if(GlobalResources.currentActiveQueue > 0):
				$Button_navigation_node_parent/EventSprite_NotifyerUI.visible = true
			EndButton.disable()
			await get_tree().create_timer(2.0).timeout 
			ArrowButton[0].visible = false
			ArrowButton[1].visible = true
			EndButton.enable()
			if($"../TutorialPanel_Folder/TutorialPanel3"):
				$"../TutorialPanel_Folder/TutorialPanel3".visible = true
			
		1:#Lobby
			if GlobalResources.currentActiveQueue > 0:
				await get_tree().create_timer(0.2).timeout
				$"../EventHandler".isEventVisible = false
				$"../EventHandler".switchIt(false)
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
				MoveObjectSmoothly(ObjectLeft,Vector2(-1950,-600),1.5)
			else:
				tween.kill()
				self.position = SpecificLocation[LocationKey]
			$Button_navigation_node_parent/MeteorCyce.show()
			EndButton.enable()
			if(GlobalResources.currentActiveQueue > 0):
				$Button_navigation_node_parent/EventSprite_NotifyerUI.visible = true
			EndButton.disable()
			await get_tree().create_timer(2.0).timeout 
			EndButton.enable()
			ArrowButton[0].visible = true
			ArrowButton[1].visible = true


		2:#DrivingsRoom
			$Button_navigation_node_parent/MeteorCyce.show()
			if position == SpecificLocation[2]:
				return
			var TimerFilter = false
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
				TimerFilter = true
			else:
				tween.kill()
				self.position = SpecificLocation[LocationKey]
			ArrowButton[0].visible = true
			ArrowButton[1].visible = false
			if TimerFilter:
				await get_tree().create_timer(1.5).timeout
				if($"../TutorialPanel_Folder/TutorialPanel2"):
					$"../TutorialPanel_Folder/TutorialPanel2".visible = true
				pass
			if GlobalResources.currentActiveQueue > 0:
				EndButton.disable()
				await get_tree().create_timer(0.5).timeout
				$"../EventHandler".isEventVisible = true
				$"../EventHandler".switchIt()
			else: EndButton.enable()



		3: #StorageRoom
			EndButton.enable()
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
			else:
				tween.kill()
				self.position = SpecificLocation[LocationKey]
			$Button_navigation_node_parent/MeteorCyce.show()
			ArrowButton[0].visible = false
			ArrowButton[1].visible = false


		4: #Cycle Report
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
			else:
				self.position = SpecificLocation[LocationKey]
			$"../CycleReport/ClickAnywhereButton/CycleReport_ScrollContainer".onCall()
			ArrowButton[0].visible = false
			ArrowButton[1].visible = false
			EndButton.visible = false


		5: #ExpeditionRoom
			$"../ExpeditionSelection".uponCall()
			ArrowButton[0].visible = false
			ArrowButton[1].visible = false
			EndButton.enable()
			position = SpecificLocation[LocationKey]
			pass
	$"..".EndCycle_Can_Be_Click_ = true
	#print("DEBUGGING LOCATION// KEY LOCATION:", LocationKey,"// position: ", self.position)


func ChangeSpecificScene(_LocationKey):
	if _LocationKey < 6 and _LocationKey > -1:
		if !nonCommonPanningRooms.has(self.position) and !nonCommonPanningRooms.has(SpecificLocation[_LocationKey]):
			LocationKey = _LocationKey
			ChangeLocaton(true)
		else:
			LocationKey = _LocationKey
			ChangeLocaton(false)
	else:
		print("CameraMovement.gd//Line - 84//ERROR: MISUSED OF LOCATIONKEY: EXPECTED BETWEEN '0','1','2','3': VALUE RECEIVE = ", _LocationKey)


func MoveObjectSmoothly(ObjectName, Location, Duration):
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE) 
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(ObjectName, "position", Location, Duration)


func _on_left_button_ui_pressed() -> void:
	ChangeLocationToLeft()


func _on_right_button_ui_pressed() -> void:
	ChangeLocationToRight()


func _on_click_cooldown_timeout() -> void:
	if self.position != SpecificLocation[4]:
		EndButton.visible = true
	canBeClick = true


func _on_button_to_storage_room_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
			LocationKey = 3
			ChangeLocaton(false)


func _on_click_anywhere_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var cycleReport_container = $"../CycleReport/ClickAnywhereButton/CycleReport_ScrollContainer"
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		if !cycleReport_container._isDoneShowing:
			cycleReport_container._Delay = 0.2
			return
		$"../EventHandler".isEventVisible = true
		cycleReport_container.deleteChild()
		IngameStoredProcessSetting.Cycle_ReportList.clear()
		LocationKey = 2
		ChangeLocaton(false)
		#$"../EventHandler".switchIt()
		$"../WholeInteriorScene/Lobby".set_initialDialogue()



func _on_click_on_left_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
			position = SpecificLocation[0]
			canBeClick = true
			ChangeSpecificScene(0)
			ArrowButton[0].hide()
			ArrowButton[1].show()
