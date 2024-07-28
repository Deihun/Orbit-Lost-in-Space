extends Control

var navigation_score = 0

@onready var camera = $cam2d
@onready var buttonUI = $Button_navigation_node_parent

func _process(delta):
	if Input.is_key_pressed(KEY_LEFT):
		if navigation_score > -2:
				navigation_score -= 1
	elif Input.is_key_pressed(KEY_RIGHT):
		if navigation_score < 1:
			navigation_score += 1
	change_UI()




func _ready():
	change_UI()
	pass 


func _on_texture_button_pressed():
	if navigation_score > -2:
		navigation_score -= 1
		change_UI()

func _on_right_button_ui_pressed():
	if navigation_score < 1:
		navigation_score += 1
		change_UI()


func change_UI():
	match navigation_score:
		-1:
			
			camera.position = Vector2(-1200,0)
			buttonUI.position = getButtonPosition()
		0:
			camera.position = Vector2(0,0)
			buttonUI.position = getButtonPosition()
		1:
			camera.position = Vector2(1200,0)
			buttonUI.position = getButtonPosition()
		2: 
			camera.position = Vector2(2400,0)
			buttonUI.position = getButtonPosition()
			
func getButtonPosition():
	return camera.position + Vector2(-550,100)



