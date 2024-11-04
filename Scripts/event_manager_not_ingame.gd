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
	if CommandList.size() > 0:
		new_event["Command"] = CommandList
	if _Condition_ValueGroup.size() > 0:
		print("more than shit")
		new_event["Conditions"] = _Condition_ValueGroup.duplicate(true)
	event_data.append(new_event)
	if _probabilityGroup.size()> 0:
		var a = _probabilityGroup.duplicate(true)
		new_event["Probability"] = a
		_probabilityGroup.clear()
		_RemoveCommand_Probability()
	save_json_file()
	update_UI()
	reset_items()
	_ConditionGroupsReset()

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
	var json_string = JSON.stringify(event_data)
	var formatted_string = json_string.replace("},", "},\n").replace("[", "[\n").replace("]", "\n]").replace("Repeatable", "\nRepeatable").replace("description","\ndescription").replace("id","\nid")
	var label = $ScrollContainer_CodePreview/VScrollBar_CodePreview/Label
	$Label_id.text = str("ID: ", get_next_event_id())
	label.text = str(formatted_string)
	label.autowrap_mode = true
	$Panel_ButtonGeneration/ScrollContainer_CodePreview_Item/VScrollBar_CodePreview/Label.autowrap_mode = true
	$Panel_ButtonGeneration/ScrollContainer_CodePreview_Item/VScrollBar_CodePreview/Label.text = str(current_Items)
	$Panel_ButtonGeneration/ScrollContainer_CodePreview_ChoicePreview/VScrollBar_CodePreview/Label.text = str(TemporaryChoices)
	$Panel_ButtonGeneration/ScrollContainer_CodePreview_ChoicePreview/VScrollBar_CodePreview/Label.autowrap_mode = true
	$Panel_Command/ScrollContainer_CodePreview_Item/VScrollBar_CodePreview/Label.text = str(CommandList)
	$Panel_Command/ScrollContainer_CodePreview_Item/VScrollBar_CodePreview/Label.autowrap_mode = true
	$Panel_Conditions/ScrollContainer_CodePreview_ChoicePreview/VScrollBar_CodePreview/Label.text = str(_Condition_ValueGroup)
	$Panel_Conditions/ScrollContainer_CodePreview_ChoicePreview/VScrollBar_CodePreview/Label.autowrap_mode = true
	$Panel_Probability/ScrollContainer_CodePreview_ChoicePreview_ProbabilityCommandGroup/VScrollBar_CodePreview/Label.text = str(_Probability_Command)
	$Panel_Probability/ScrollContainer_CodePreview_ChoicePreview_ProbabilityCommandGroup/VScrollBar_CodePreview/Label.autowrap_mode = true
	$Panel_Probability/ScrollContainer_CodePreview_ChoicePreview_ProbabilityGroup/VScrollBar_CodePreview/Label.text = str(_probabilityGroup)
	$Panel_Probability/ScrollContainer_CodePreview_ChoicePreview_ProbabilityGroup/VScrollBar_CodePreview/Label.autowrap_mode
	var font_size = label.get_theme_font_size("font_size")  # Get the font size from the theme
	var line_count = label.get_line_count()  # Get the number of lines
	#label.custom_minimum_size = Vector2(0, font_size * line_count)

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
	$Panel_ButtonGeneration/ScrollContainer_CodePreview_Item/VScrollBar_CodePreview/Label.text= ""

func clear_item_UI():
	$Panel_ButtonGeneration/LineEdit_amount.text = ""

func on_finalize_choice_button():
	var description = $Panel_ButtonGeneration/TextEdit_Description.text.strip_edges()
	var targetId = int($Panel_ButtonGeneration/LineEdit_ID.text)
	if !$Panel_ButtonGeneration/CheckButton_Hidden.is_pressed():
		TemporaryChoices["Choice-"+str(current_choice_id+1)] = [
			targetId,
			current_Items,
			description
		]
		current_choice_id +=1
	else:
		if TemporaryChoices.keys().has("HiddenChoice"):
			print("ERROR: HiddenChoice can only be called once")
			return
		#if $Panel_ButtonGeneration/Panel_HiddenChoice/Conditional_OptionButton.text == "HAS_UNIQUE_ITEM":
		TemporaryChoices["HiddenChoice"] = [
			[
				[str($Panel_ButtonGeneration/Panel_HiddenChoice/Conditional_OptionButton.text),
				[str($Panel_ButtonGeneration/Panel_HiddenChoice/_ItemName.text.to_upper()), 
				int($Panel_ButtonGeneration/Panel_HiddenChoice/LineEdit_Amount.text)
			]]],
			[targetId ,current_Items,	description
		]
		]
	update_UI()

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
	pass # Replace with function body.

#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#						COMMAND TAB
var CommandList = []
func _EnterCommand() -> void:
	var line = str($Panel_Command/LineEdit_Command.text)
	CommandList.append(line)
	update_UI()
	pass # Replace with function body.


func _ClearCommand() -> void:
	CommandList.clear()
	update_UI()
	pass # Replace with function body.
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#						ConditionTab
var _Condition_ValueGroup = []


func _AddValue() -> void:
	_ConditionGroupsReset()
	#_Condition_ValueGroup[0][0] = $Panel_Conditions/Conditional_OptionButton.text
	#_Condition_ValueGroup[0][1] = $Panel_Conditions/LineEdit_Value.text
	#_Condition_ValueGroup = [[$Panel_Conditions/Conditional_OptionButton.text][$Panel_Conditions/LineEdit_Value.text]]
	_Condition_ValueGroup.append($Panel_Conditions/Conditional_OptionButton.text)
	_Condition_ValueGroup.append($Panel_Conditions/LineEdit_Value.text)
	update_UI()
	pass # Replace with function body.


func _ConditionGroupsReset() -> void:
	_Condition_ValueGroup.clear()
	update_UI()
	pass # Replace with function body.
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
	_ClearCommand()
	_probabilityGroup.clear()

func _on_button_clear_button_up() -> void:
	clear()
	pass # Replace with function body.
