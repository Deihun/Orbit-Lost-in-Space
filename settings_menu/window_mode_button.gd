extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton
@onready var resolution_mode_button: Control = NodeFinder.find_node_by_name(get_tree().current_scene, "Resolution_Mode_Button")

var fullmode

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-Screen",
	"window Mode",
	"Boderless Window",
	"Boderless Full-Screen"
]

func _ready():
	add_window_mode_items()
	option_button.item_selected.connect(on_window_mode_selected)
	load_data()
	
func load_data() -> void:
	on_window_mode_selected(SettingsDataContainer.get_window_mode_index())
	option_button.select(SettingsDataContainer.get_window_mode_index())
	
func add_window_mode_items() -> void:
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)
	
func on_window_mode_selected(index : int) -> void:
	SettingsSignalBus.emit_on_window_mode_selected(index)
	match index:
		0: #fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			fullmode = true
		1: #window mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			fullmode = false
		2: #Borderless Window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			fullmode = false
		3: #Borderless Window full
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			fullmode = true

func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			fullmode = true
			resolution_mode_button.checkResolution()
		1:
			fullmode = false
			resolution_mode_button.checkResolution()
		2:
			fullmode = false
			resolution_mode_button.checkResolution()
		3:
			fullmode = true
			resolution_mode_button.checkResolution()
