extends Node2D
@onready var up = $Move_ControlPanel/UP
@onready var down = $Move_ControlPanel/DOWN
@onready var left = $Move_ControlPanel/LEFT
@onready var right = $Move_ControlPanel/RIGHT
@onready var interacting : Label = $Interact_Panel/INTERACT
var fade_duration = 2.0 # Duration for the fade-out in seconds
var start_alpha = 1.0
var end_alpha = 0.0
var elapsed_time = 0.0
var alreadyCalledStart : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	up.text = cutAKey("ui_up")
	down.text = cutAKey("ui_down")
	left.text = cutAKey("ui_left")
	right.text = cutAKey("ui_right")
	interacting.text = cutAKey("Interact")
	interacting.position.x += interacting.text.length() * 2
	#$Interact_Panel/NinePatchRect.custom_minimum_size = interacting.custom_minimum_size + Vector2(150,50)
	$Interact_Panel/NinePatchRect.offset_left -= interacting.text.length() *4
	$Interact_Panel/NinePatchRect.offset_right += interacting.text.length() *4
	$Interact_Panel/NinePatchRect.position = Vector2(168,294)
	


func cutAKey(ui_map : String):
	var input_event = InputMap.action_get_events(ui_map)  # Assuming this method or similar exists
	var event_string = str(input_event[0])
	var start_index = event_string.find("(") + 1
	var end_index = event_string.find(")")
	var key_name = event_string.substr(start_index, end_index - start_index)
	return key_name

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Show_Tutorial"):
		Turn_In()


func Turn_In():
	$".".modulate.a = 1.0


func fadeOut():
	if modulate.a != 1.0: return
	$tutorialAssets_Player.play("Fadeout")


func _on_fadeout_effect_timeout() -> void:
	pass # Replace with function body.
