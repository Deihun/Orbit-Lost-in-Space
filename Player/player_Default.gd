extends Node2D
@export var show_timer : bool = true
@export var cameraZoom : float
@export var Smoothing_CameraTrack : bool = true
@export var can_Move : bool = true

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
