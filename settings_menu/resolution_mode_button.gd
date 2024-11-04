extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton
@onready var window_mode_button: Control = NodeFinder.find_node_by_name(get_tree().current_scene, "Window_Mode_Button")


const RESOLUTION_DICTIONARY : Dictionary = {
	"1920 x 1080" : Vector2i(1920, 1080),
	"1280 x 720" : Vector2i(1280, 720),
	"854 x 480" : Vector2i(854, 480),
	"640 x 480" : Vector2i(640, 480),
	"640 x 360" : Vector2i(640, 360)
}

func _ready():
	await get_tree().create_timer(0.01).timeout
	window_mode_button = NodeFinder.find_node_by_name(get_tree().current_scene, "Window_Mode_Button")
	add_resolution_items()
	load_data()
	option_button.item_selected.connect(on_resolution_selected)
	checkResolution()
	
func checkResolution():
	if window_mode_button.fullmode == true:
		option_button.disabled = true
	elif window_mode_button.fullmode == false:
		option_button.disabled = false
	
func load_data() -> void:
	on_resolution_selected(SettingsDataContainer.get_resolution_index())
	option_button.select(SettingsDataContainer.get_resolution_index())

func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)
	
func on_resolution_selected(index : int) -> void:
	SettingsSignalBus.emit_on_resolution_selected(index)
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	
