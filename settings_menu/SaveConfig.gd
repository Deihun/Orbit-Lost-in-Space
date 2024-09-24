extends Node

@onready var keybinds = NodeFinder.find_node_by_name(get_parent().get_tree().current_scene, "Hotkey_Rebind_Button")
var configfile = "settings_menu/config_file.json"

func savedata():
	if !keybinds :
		print("null")
	var save_dict = {
		"ui_up": keybinds.keybindsSaving[0],
		"ui_left": keybinds.keybindsSaving[1],
		"ui_down": keybinds.keybindsSaving[2],
		"ui_right": keybinds.keybindsSaving[3],
		"Interact": keybinds.keybindsSaving[4]
	}
	return save_dict

func saveconfig():
	print("saved")
	var file = FileAccess.open(configfile, FileAccess.WRITE)
	var json_string = JSON.stringify(savedata())
	file.store_line(json_string)
	
func loadconfig():
	if not FileAccess.file_exists(configfile):
		return
	var file = FileAccess.open(configfile, FileAccess.READ)
		
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()	
		
		#while file.get_position() < file.get_length():
		#	InputMap.action_erase_events(node_data["ui_up"])
		#	InputMap.action_add_event(node_data["ui_up"])
		#	#update_action_list(remapping_button, event)

	print("loaded")
