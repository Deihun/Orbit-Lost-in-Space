extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = $Player/player
	var player_camera : Camera2D = $Player/player/PlayerCamera
	var tutorialAssets = $Player/player/AllUIParents/TutorialAssets
	var GlobaUI = $Player/player/AllUIParents/Globe_Timer_Sprite
	var inventory = $Player/player/AllUIParents/UI_On_Hand
	var timer = $Player/player/AllUIParents/Timer
	
	
	inventory.visible = true
	player.canMove = true
	tutorialAssets.visible = true
	
	player_camera.make_current()
	var shader = $Background/Tutorialscenes.material as ShaderMaterial
	shader.set_shader_parameter("base_color", Color(1, 1, 1, 1))
	shader.set_shader_parameter("light_intensity", 0.65)
	timer.hide()
	GlobaUI.hide()
