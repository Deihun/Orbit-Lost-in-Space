extends Node2D

@export_group("PlayerSettings")
@export var can_Move : bool = true
@export var Smoothing_CameraTrack : bool = true
@export var crew_icon_bar_Show : bool = false
@export var equipHelmet : bool = false
@export var AdditionalPlayerSpeed : int = 0

@export_group("UI_Settings")
@export var cameraZoom : float
@export var show_timer : bool = true
@export var show_crewInventoryUI: bool = true
@export var show_inventoryUI : bool = true
@export var show_tutorialTip : bool = true
@export var useGlobeTimerUI : bool = true

@export_group("Game Settings")
@export var canRestartOnGameOver : bool = false
@export_subgroup("Time Limit")
@export var activate_timeLimit : bool = true
@export var delayBeforeGameStart : float = 6.0
@export var limitTimeDuration : int = 90

func _ready() -> void:
	$player.animation_use_id = 1 if equipHelmet else 0
	showTimer(show_timer)
	canMove(can_Move)
	_smoothCameraTrack(Smoothing_CameraTrack)
	setStats()
	pass # Replace with function body.

func setStats():
	if IngameStoredProcessSetting.selectedCrew == "" or "Jerry":
		AdditionalPlayerSpeed = 100
		$player/AllUIParents/UI_On_Hand.MAX_SLOTS = 4
		IngameStoredProcessSetting.BonusMultiplyer = 1
	AdditionalPlayerSpeed = IngameStoredProcessSetting.speed

func showTimer(value : bool):
	if value and $".".useGlobeTimerUI:
		$player/AllUIParents/Globe_Timer_Sprite.show()
		$player/AllUIParents/Globe_Timer_Sprite/Label_Timer.show()
	elif value and !$".".useGlobeTimerUI:
		$player/AllUIParents/Timer.show()
	else:
		$player/AllUIParents/Globe_Timer_Sprite.hide()
		$player/AllUIParents/Globe_Timer_Sprite/Label_Timer.hide()

func canMove(value : bool):
	if value:
		$player.canMove = true
	else: 
		$player.canMove = false

func _smoothCameraTrack(value : bool):
	$player/PlayerCamera.position_smoothing_enabled = value

func gameStart():
	$player.gameStart()

func gameWin():
	$player.gameWin()

func transition():
	$player/AllUIParents/Transition.show()
	$player/AllUIParents/Transition/AnimationPlayer.play("FadeToBlack")
	await get_tree().create_timer(2.5).timeout
	$player/AllUIParents/Transition.hide()

func with_helmet():
	await get_tree().create_timer(0.3).timeout
	$player.animation_use_id = 1
