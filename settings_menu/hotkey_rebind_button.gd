class_name HotkeyRebindButton
extends Control

@onready var input_button_scene = preload("res://input_button.tscn")
@onready var action_list = $MarginContainer/VBoxContainer/ScrollContainer/ActionList
@onready var popup = $MarginContainer/VBoxContainer/AlreadyTakenIndicator
@onready var label_TakenIndicator = $MarginContainer/VBoxContainer/AlreadyTakenIndicator/Label

var is_remapping = false
var action_to_remap = null
var remapping_button = null
var alreadyTakenKey = []

var input_actions = {
	"ui_up": "Move up",
	"ui_left": "Move left",
	"ui_down": "Move down",
	"ui_right": "Move right",
	"Interact": "Interact"
}

func _ready():
	_load_keybindings_from_settings()
	_create_action_list()

func _load_keybindings_from_settings():
	var keybindings = ConfigFileHandler.load_keybindings()
	for action in keybindings.keys():
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, keybindings[action])

func _create_action_list():
	#InputMap.load_from_project_settings()

	for item in action_list.get_children():
		item.queue_free()

	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)

		# Debug the events retrieval
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""

		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press any key to bind..."

func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			#For double click 
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			var _event = fixMouse(str(event))
			
			updateKeyIdentifyerArray()
			if(alreadyTakenKey.has(event.as_text().trim_suffix(" (Physical)"))):
				show_key_already_used_popup(event)
				return
			
			#InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			ConfigFileHandler.save_keybinding(action_to_remap, event)
			update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			accept_event()
			 
func update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")
	print("This key is: ", event.as_text().trim_suffix(" (Physical)"), " if it is inside the array here? ", alreadyTakenKey)


func _on_reset_button_pressed() -> void:
	InputMap.load_from_project_settings()
	for action in input_actions:
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			ConfigFileHandler.save_keybinding(action, events[0])
	_create_action_list()

func updateKeyIdentifyerArray():
	alreadyTakenKey.clear()
	for ui_map in input_actions:
		var input_event = InputMap.action_get_events(ui_map)
		var event_string = str(input_event[0])
		print(ui_map)
		alreadyTakenKey.append(keyChecker(event_string))

func keyChecker(event_string : String):
	if event_string.begins_with("InputEventMouseButton"):
		var start_index = event_string.find("button_index=")
		var end_index = event_string.find(", mods=")
		var key_name = event_string.substr(start_index, end_index - start_index)
		return key_name
	else:
		var start_index = event_string.find("(") + 1
		var end_index = event_string.find(")")
		var key_name = event_string.substr(start_index, end_index - start_index)
		return key_name
		
func fixMouse(mouse_StringEvent : String):
	if mouse_StringEvent == "Left Mouse Button":
		return "button_index=1"
	elif mouse_StringEvent == "Left Mouse Button":
		return "button_index=1"
	else:
		return mouse_StringEvent

func show_key_already_used_popup(event):
	var message : String = "Key '" + event.as_text().trim_suffix(" (Physical)") + "' is already used!"
	label_TakenIndicator.text = message
	popup.popup_centered()
