extends Node2D

@export_group("PlayerSettings")
@export var can_Move : bool = true
@export var Smoothing_CameraTrack : bool = true
@export var crew_icon_bar_Show : bool = false
@export var AdditionalPlayerSpeed : int = 0

@export_group("UI_Settings")
@export var cameraZoom : float
@export var show_timer : bool = true
@export var show_crewInventoryUI: bool = true
@export var show_inventoryUI : bool = true
@export var show_tutorialTip : bool = true
@export var useGlobeTimerUI : bool = true

@export_group("Game Settings")
@export_subgroup("Time Limit")
@export var activate_timeLimit : bool = true
@export var delayBeforeGameStart : float = 6.0
@export var limitTimeDuration : int = 90


func _ready() -> void:
	showTimer(show_timer)
	canMove(can_Move)
	_smoothCameraTrack(Smoothing_CameraTrack)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func showTimer(value : bool):
	if value:
		$player/AllUIParents/Globe_Timer_Sprite.show()
		$player/AllUIParents/Label_Timer.show()
	else:
		$player/AllUIParents/Globe_Timer_Sprite.hide()
		$player/AllUIParents/Label_Timer.hide()

func canMove(value : bool):
	if value:
		$player.canMove = true
	else: 
		$player.canMove = false

func _smoothCameraTrack(value : bool):
	$player/PlayerCamera.position_smoothing_enabled = value

func gameStart():
	$player.gameStart()
