extends Camera2D

@onready var ArrowButton = [$Button_navigation_node_parent/LeftButton_UI,$Button_navigation_node_parent/RightButton_UI]
@onready var ObjectLeft = Node2D
var SpecificLocation = [Vector2(-3100,0),Vector2(-100,0),Vector2(2950,0)]

var LocationKey = 1
var canBeClick = true

@onready var ClickCD = $Button_navigation_node_parent/ClickCooldown

func _ready() -> void:
	var parent = get_parent()
	ObjectLeft = parent.get_node("OnCameraMovingDesign/Left_Groups_of_Objects")
	LocationKey = 1
	ChangeLocaton()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_A):
		ChangeLocationToLeft()
	elif Input.is_key_pressed(KEY_D):
		ChangeLocationToRight()


func ChangeLocationToLeft():
	if canBeClick == true:
		if LocationKey > 0:
			canBeClick = false
			LocationKey -= 1
			ChangeLocaton()
			ClickCD.start()

func ChangeLocationToRight():
	if canBeClick == true:
		if LocationKey < 2:
			canBeClick = false
			LocationKey += 1
			ChangeLocaton()
			ClickCD.start()

func ChangeLocaton():
	match(LocationKey):
		0:
			MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
			MoveObjectSmoothly(ObjectLeft,Vector2(-1500,-600),1.5)
			ArrowButton[0].visible = false
			ArrowButton[1].visible = true
		1:
			MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
			MoveObjectSmoothly(ObjectLeft,Vector2(-1950,-600),1.5)
			ArrowButton[0].visible = true
			ArrowButton[1].visible = true
		2:
			MoveObjectSmoothly(self,SpecificLocation[LocationKey],2)
			ArrowButton[0].visible = true
			ArrowButton[1].visible = false
	#print("DEBUGGING LOCATION// KEY LOCATION:", LocationKey,"// position: ", self.position)


func ChangeSpecificScene(_LocationKey):
	if _LocationKey < 2 or _LocationKey > 0:
		LocationKey = _LocationKey
		ChangeLocaton()
	else:
		print("CameraMovement.gd//Line - 50//ERROR: MISUSED OF LOCATIONKEY: EXPECTED BETWEEN '-1','0','1': VALUE RECEIVE = ", _LocationKey)


func MoveObjectSmoothly(ObjectName, Location, Duration):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(ObjectName, "position", Location, Duration)



func _on_left_button_ui_pressed() -> void:
	ChangeLocationToLeft()


func _on_right_button_ui_pressed() -> void:
	ChangeLocationToRight()


func _on_click_cooldown_timeout() -> void:
	canBeClick = true
	print("Can be click again: ", canBeClick)
