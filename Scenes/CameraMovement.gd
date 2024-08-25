extends Camera2D

@onready var ArrowButton = [$Button_navigation_node_parent/LeftButton_UI,$Button_navigation_node_parent/RightButton_UI]
@onready var ObjectLeft = Node2D
@onready var EndButton = get_parent().get_node("cam2d/Button_navigation_node_parent/NextDay_Button")

var tween = create_tween()
var SpecificLocation = [Vector2(-3100,0),Vector2(-100,0),Vector2(2950,0), Vector2(-3000,1500), Vector2(-3000,3000)]
var nonCommonPanningRooms = [Vector2(-3000,1500), Vector2(-3000,3000)]


var LocationKey = 1
var canBeClick = true

@onready var ClickCD = $Button_navigation_node_parent/ClickCooldown

func _ready() -> void:
	var parent = get_parent()
	ObjectLeft = parent.get_node("OnCameraMovingDesign/Left_Groups_of_Objects")
	ChangeSpecificScene(1)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_A):
		ChangeLocationToLeft()
	elif Input.is_key_pressed(KEY_D):
		ChangeLocationToRight()


func ChangeLocationToLeft():
	if canBeClick == true:
		if LocationKey > -1 and LocationKey < 3:
			canBeClick = false
			LocationKey -= 1
			ChangeLocaton(true)
			EndButton.visible = false
			ClickCD.start()

func ChangeLocationToRight():
	if canBeClick == true:
		if LocationKey < 3 and LocationKey > -1:
			canBeClick = false
			LocationKey += 1
			ChangeLocaton(true)
			EndButton.visible = false
			ClickCD.start()

func ChangeLocaton(smoothMovement):

		
	
	match(LocationKey):
		0:#CraftingRoom
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
				MoveObjectSmoothly(ObjectLeft,Vector2(-1500,-600),1.5)
			ArrowButton[0].visible = false
			ArrowButton[1].visible = true
			EndButton.visible = true
		1:#Lobby
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
				MoveObjectSmoothly(ObjectLeft,Vector2(-1950,-600),1.5)
			else:
				tween.kill()
				self.position = SpecificLocation[LocationKey]
			ArrowButton[0].visible = true
			ArrowButton[1].visible = true
		2:#DrivingsRoom
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
			else:
				tween.kill()
				self.position = SpecificLocation[LocationKey]
			ArrowButton[0].visible = true
			ArrowButton[1].visible = false
			EndButton.visible = true
		3: #StorageRoom
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
			else:
				tween.kill()
				self.position = SpecificLocation[LocationKey]
			ArrowButton[0].visible = false
			ArrowButton[1].visible = false
		4: #Cycle Report
			if smoothMovement:
				MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
			else:
				self.position = SpecificLocation[LocationKey]
				
			ArrowButton[0].visible = false
			ArrowButton[1].visible = false
			EndButton.visible = false
	#print("DEBUGGING LOCATION// KEY LOCATION:", LocationKey,"// position: ", self.position)


func ChangeSpecificScene(_LocationKey):
	print(_LocationKey)
	if _LocationKey < 5 and _LocationKey > -1:
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
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
			LocationKey = 2
			ChangeLocaton(false)


func _on_end_cycle_timer_timeout() -> void:
	pass # Replace with function body.
