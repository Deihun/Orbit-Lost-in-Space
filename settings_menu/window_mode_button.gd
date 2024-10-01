extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-Screen",
	"window Mode",
	"Boderless Window",
	"Boderless Full-Screen"
]

func _ready():
	option_button.item_selected.conncet(on_window_mode_selected)
	
func on_window_mode_selected(index : int) -> void:
	match index:
		0: #fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			
