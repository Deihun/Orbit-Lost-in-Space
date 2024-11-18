extends Control

var json_file_path = "res://Scripts/Events.json"
var event_data = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_json_file()
	update_UI()
	pass # Replace with function body.

func load_json_file():
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	
	if file:
		var json_string = file.get_as_text()
		file.close()
		
		if json_string != "":
			var json = JSON.parse_string(json_string)
			if json is Array:
				event_data = json
			else:
				event_data = []
				print("Parsing Error")
		else:
			event_data = []
			print("File is empty, initializing new event list")
	else:
		event_data = []
		print("JSON file does not exist, creating new empty event list")


func add_new_event():
	on_finalize_choice_button()
	setUpCommandList()
	setUpCondition()
	var name_input = $Label_name/LineEdit.text
	var description_input =$Label_description/TextEdit.text
	
	if name_input == "" or description_input =="":
		print("Please fill both name and description")
		return
	
	var new_event = {
		"id" : get_next_event_id(),
		"name": name_input,
		"description": description_input,
		"RandomTrue": $CheckButton_Active.is_pressed(),
		"Repeatable": $CheckButton_Repeatable.is_pressed()
	}
	for choice_id in TemporaryChoices.keys():
		new_event[choice_id] = TemporaryChoices[choice_id]
	if $OtherSubComponents/ScrollContainer/VBoxContainer/_Command_Module.canBeUsed():
		new_event["Command"] = CommandList.duplicate()
	if $OtherSubComponents/ScrollContainer/VBoxContainer/Conditions_Components/Panel/_UseCondition_CheckButton.is_pressed():
		new_event["Conditions"] = _Condition_ValueGroup.duplicate(true)
	event_data.append(new_event)
	if $OtherSubComponents/ScrollContainer/VBoxContainer/_Probability_Module.canBeCall():
		var a = $OtherSubComponents/ScrollContainer/VBoxContainer/_Probability_Module.get_value().duplicate()
		new_event["Probability"] = a
		_probabilityGroup.clear()
		_RemoveCommand_Probability()
	save_json_file()
	update_UI()
	reset_items()


func save_json_file():
	var file = FileAccess.open(json_file_path, FileAccess.WRITE)
	
	if file:
		var json_string = JSON.stringify(event_data, "\t")  # Format with indentation for readability
		file.store_string(json_string)
		file.close()
		print("Event added and file saved.")

func get_next_event_id() -> int:
	var max_id = 0
	for event in event_data:
		if event.has("id"):
			max_id = max(max_id, event["id"])
	return max_id + 1
	pass

func update_UI():
	$Viewing.updateViewer(event_data)
	var json_string = JSON.stringify(event_data)
	var formatted_string = json_string.replace("},", "},\n").replace("[", "[\n").replace("]", "\n]").replace("Repeatable", "\nRepeatable").replace("description","\ndescription").replace("id","\nid")
	var label = $ScrollContainer_CodePreview/VScrollBar_CodePreview/Label
	$Label_id.text = str("ID: ", get_next_event_id())
	label.text = str(formatted_string)
	label.autowrap_mode = true
	var font_size = label.get_theme_font_size("font_size")  # Get the font size from the theme
	var line_count = label.get_line_count()  # Get the number of lines
	#label.custom_minimum_size = Vector2(0, font_size * line_count)

func remove_data_by_id(id_to_remove):
	event_data = event_data.filter(func(item):
		return !(item.has("id") && item["id"] == id_to_remove)
	)
	save_json_file()
	update_UI()

#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#BUTTON GENERATION UI
var current_Items = []
var current_choice_id = 0
var TemporaryChoices = {}

func _on_line_edit_text_changed(new_text: String) -> void:
	var list_Number = ["0","1","2","3","4","5","6","7","8","9",]
	var filtered_text = ""
	for i in range(new_text.length()):
		var char = new_text[i]
		if list_Number.has(char):
			filtered_text = filtered_text + char
			filtered_text = str(min(int(filtered_text), get_next_event_id()-1))
	$Panel_ButtonGeneration/LineEdit_ID.text = filtered_text  

func add_items():
	var label = $Panel_ButtonGeneration/ScrollContainer_CodePreview_Item/VScrollBar_CodePreview/Label
	var target_id = int($Panel_ButtonGeneration/LineEdit_ID.text.strip_edges())
	var description = $Panel_ButtonGeneration/TextEdit_Description.text.strip_edges()
	var items = []
	var item_name = $Panel_ButtonGeneration/ItemType_OptionButton.text.to_upper()
	var item_amount= int($Panel_ButtonGeneration/LineEdit_amount.text.strip_edges())
	
	current_Items.append([item_name, int(item_amount)])
	print(current_Items)
	clear_item_UI()
	update_UI()

func reset_items():
	current_Items.clear()


func clear_item_UI():
	pass

func on_finalize_choice_button():
	for child in $Create_ChoiceButton/ButtonScroll_Container/VBoxContainer_CreateButtonModule.get_children():
		var choice_data = child.get_value().duplicate() # Duplicate the choice data

		if typeof(choice_data[0]) == TYPE_ARRAY and choice_data[0].size() > 0:
			TemporaryChoices["HiddenChoice"] = choice_data
		else:
			TemporaryChoices["Choice-" + str(current_choice_id + 1)] = choice_data
			current_choice_id += 1

		child.queue_free()


func _Hidden_Choice_Toggle() -> void:
	if !$Panel_ButtonGeneration/CheckButton_Hidden.is_pressed():
		$Panel_ButtonGeneration/Panel_HiddenChoice.visible = false
	else: 
		$Panel_ButtonGeneration/Panel_HiddenChoice.visible = true
	pass # Replace with function body.


func _ClearItems() -> void:
	current_Items.clear()
	update_UI()
	pass # Replace with function body.


func _RESET_TemporaryITEM() -> void:
	current_choice_id = 0
	TemporaryChoices.clear()
	update_UI()


#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#						COMMAND TAB
var CommandList = []

func setUpCommandList():
	CommandList.clear()
	CommandList = $OtherSubComponents/ScrollContainer/VBoxContainer/_Command_Module.get_value().duplicate()



#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#						ConditionTab
var _Condition_ValueGroup = []

func setUpCondition():
	_Condition_ValueGroup.clear()
	_Condition_ValueGroup.append($OtherSubComponents/ScrollContainer/VBoxContainer/Conditions_Components/Panel/Conditional_OptionButton.text)
	_Condition_ValueGroup.append($OtherSubComponents/ScrollContainer/VBoxContainer/Conditions_Components/Panel/Condition_Value_LineText.text)


#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#						Probability
var _Probability_Command = []
var _probabilityGroup = []


func _AddCommand_Probability() -> void:
	if $Panel_Probability/LineEdit_Probability_Command.text == "":
		return
	_Probability_Command.append($Panel_Probability/LineEdit_Probability_Command.text)
	$Panel_Probability/LineEdit_Probability_Command.text = ""
	update_UI()
	pass # Replace with function body.


func _RemoveCommand_Probability() -> void:
	_Probability_Command.clear()
	update_UI()
	pass # Replace with function body.


func _ProbabilityAddGroup() -> void:
	var value = [
		int($Panel_Probability/LineEdit_Probability_Probability.text),
		_Probability_Command
		]
	
	_probabilityGroup.append(value)
	print("DEBUG COMPARISON: ", value," : ", _probabilityGroup)
	update_UI()
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
	pass # Replace with function body.

func clear():
	$Label_name/LineEdit.text = ""
	$Label_description/TextEdit.text = ""
	_RESET_TemporaryITEM() 
	reset_items()
	clear_item_UI()
	_ClearItems()
	_probabilityGroup.clear()

func _on_button_clear_button_up() -> void:
	clear()
	pass # Replace with function body.


func _on_button_add_choice_button_button_up() -> void:
	var addChoiceItem = preload("res://Scripts/button_making.tscn").instantiate()
	$Create_ChoiceButton/ButtonScroll_Container/VBoxContainer_CreateButtonModule.add_child(addChoiceItem)


func _on_button_add_choice_button_2_button_up() -> void:
	for child in $Create_ChoiceButton/ButtonScroll_Container/VBoxContainer_CreateButtonModule.get_children():
		child.queue_free()
