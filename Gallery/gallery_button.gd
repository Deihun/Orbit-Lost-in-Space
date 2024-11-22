extends Control

var getID
var getbool
var get_texture

const BLACK_HOLE_EVENT = preload("res://Scenes/EndScenes/Gallery_Endings/BlackHoleEvent.png") 
const EARTH_2_0 = preload("res://Scenes/EndScenes/Gallery_Endings/Earth2.0.png")
const JERRY_DEATH = preload("res://Scenes/EndScenes/Gallery_Endings/JerryDeath.png")
const KICK_OUT_END_SCENE = preload("res://Scenes/EndScenes/Gallery_Endings/KickOut_EndScene.png")
const LACKOFRESOURCES = preload("res://Scenes/EndScenes/Gallery_Endings/lackofresources.png")
const RADONTI_ENDING = preload("res://Scenes/EndScenes/Gallery_Endings/RadontiEnding.png")
const CTHULLU_ENDING = preload("res://Scenes/EndScenes/Gallery_Endings/Cthullu Ending.png")
const SAURIA_ENDING = preload("res://Scenes/EndScenes/Gallery_Endings/Sauria Ending.png")
const STEELICUS_ENDSCENE = preload("res://Scenes/EndScenes/Gallery_Endings/SteelicusENDSCENE.png")

var groupOfGallery = [BLACK_HOLE_EVENT,EARTH_2_0,JERRY_DEATH,KICK_OUT_END_SCENE,LACKOFRESOURCES,RADONTI_ENDING,CTHULLU_ENDING,SAURIA_ENDING,STEELICUS_ENDSCENE]

var selectedScene = 0

func _ready() -> void:
	check_if_locked()
	#set_image()
	
func set_image(id : int) -> void:
	var _id = min(groupOfGallery.size(), id)
	selectedScene = _id
	$Sprite2D.texture = groupOfGallery[_id]
	$Sprite2D.show()
	$Button.modulate.a = 0
	$Button.text = "Unlocked"


func check_if_locked() -> void:
	if !getbool:
		$Button.text = "Locked"
	if getbool:
		$Button.text = "Unlocked"


func _on_button_pressed() -> void:
	if $Button.text == "Locked": return
	
	var a = preload("res://Gallery/selected_scene_turn_on.tscn").instantiate()
	a.texture = groupOfGallery[selectedScene]
	$".".get_parent().get_parent().get_parent().add_child(a)
