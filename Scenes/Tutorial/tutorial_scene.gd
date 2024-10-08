extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = $Player/player
	var tutorialAssets = $Player/player/AllUIParents/TutorialAssets
	var inventory = $Player/player/AllUIParents/UI_On_Hand
	
	inventory.visible = true
	player.canMove = true
	tutorialAssets.visible = true
	pass # Replace with function body.
