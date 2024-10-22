extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = $Player/player
	var player_camera : Camera2D = $Player/player/PlayerCamera
	var tutorialAssets = $Player/player/AllUIParents/TutorialAssets
	var inventory = $Player/player/AllUIParents/UI_On_Hand
	
	
	inventory.visible = true
	player.canMove = true
	tutorialAssets.visible = true
	
	player_camera.make_current()
	pass # Replace with function body.
