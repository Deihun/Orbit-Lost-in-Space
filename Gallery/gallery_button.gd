extends Control

var getID
var getbool
var get_texture

func _ready() -> void:
	check_if_locked()
	#set_image()
	
func set_image() -> void:
	$Button.texture_normal = get_texture
	
func check_if_locked() -> void:
	if !getbool:
		$Button.text = "Locked"
		$Button.disabled = true
	if getbool:
		$Button.text = "Unlocked"
		#print("Unlocked")
	
func _on_button_pressed() -> void:
	pass # Replace with function body.
