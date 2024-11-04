extends Node2D

var endTitle : String

var canBeClickAgain : bool = true

func _ready() -> void:
	endTitle = IngameStoredProcessSetting.Ending
	$img_Ending.texture = getScene(endTitle)
	DialogueManager.show_dialogue_balloon(Dialogue, endTitle)
	pass


#####
var Dialogue = preload("res://DialogueSystem/End.dialogue")

var Kickout_scene = preload("res://Scenes/EndScenes/Gallery_Endings/KickOut_EndScene.png")
var lackofresources = preload("res://Scenes/EndScenes/Gallery_Endings/lackofresources.png")

func getScene(content : String):
	match content:
		"Kickout":
			$GoodEnd.text = "Bad End"
			return Kickout_scene
			
		"lackofresources":
			$GoodEnd.text = "Bad End"
			return lackofresources



func _on_button_button_up() -> void:
	if !canBeClickAgain: return
	canBeClickAgain = false
	$Panel.modulate.a = 0.0
	$Panel.show()
	while $Panel.modulate.a < 1.0:
		$Panel.modulate.a += 0.05
		await get_tree().create_timer(0.05).timeout
	await get_tree().create_timer(1.5).timeout
	$GoodEnd.show()
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
	pass # Replace with function body.
