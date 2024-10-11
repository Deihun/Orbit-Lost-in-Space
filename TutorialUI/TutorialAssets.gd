extends Node2D
@onready var up = $UP
@onready var down = $DOWN
@onready var left = $LEFT
@onready var right = $RIGHT
@onready var interacting = $INTERACT
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


func cutAKey(ui_map : String):
	var input_event = InputMap.action_get_events(ui_map)  # Assuming this method or similar exists
	var event_string = str(input_event[0])
	var start_index = event_string.find("(") + 1
	var end_index = event_string.find(")")
	var key_name = event_string.substr(start_index, end_index - start_index)
	return key_name


func fadeOut():
	
	if !alreadyCalledStart:
		alreadyCalledStart = true
	set_process(true)
	pass


func _process(delta):
	elapsed_time += delta
	var new_alpha = lerp(start_alpha, end_alpha, elapsed_time / fade_duration)
	modulate.a = new_alpha
	if elapsed_time >= fade_duration:
		modulate.a = end_alpha
		set_process(false)  # Stop processing when fade is complete
		queue_free()  # Optionally remove the node when done


func _on_fadeout_effect_timeout() -> void:
	pass # Replace with function body.
