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
		"description_input": description_input,
		"RandomTrue": $CheckButton_Active.is_pressed(),
		"Repeatable": $CheckButton_Repeatable.is_pressed()
	}
	for choice_id in TemporaryChoices.keys():
		new_event[choice_id] = TemporaryChoices[choice_id]
	
	event_data.append(new_event)
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
	var json_string = JSON.stringify(event_data)
	var formatted_string = json_string.replace("},", "},\n").replace("[", "[\n").replace("]", "\n]")
	var label = $ScrollContainer_CodePreview/VScrollBar_CodePreview/Label
	$Label_id.text = str("ID: ", get_next_event_id())
	label.text = str(formatted_string)
	label.autowrap_mode = true
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
	var item_name = $Panel_ButtonGeneration/LineEdit_item.text.strip_edges()
	var item_amount= int($Panel_ButtonGeneration/LineEdit_amount.text.strip_edges())
	current_Items.append([item_name, int(item_amount)])
	print(current_Items)
	label.text = str(current_Items)
	label.autowrap_mode = true
	clear_item_UI()

func reset_items():
	current_Items.clear()
	$Panel_ButtonGeneration/ScrollContainer_CodePreview_Item/VScrollBar_CodePreview/Label.text= ""

func clear_item_UI():
	$Panel_ButtonGeneration/LineEdit_item.text = ""
	$Panel_ButtonGeneration/LineEdit_amount.text = ""

func on_finalize_choice_button():
	var description = $Panel_ButtonGeneration/TextEdit_Description.text.strip_edges()
	TemporaryChoices["choice-"+str(current_choice_id+1)] = [
		int(current_choice_id),
		current_Items,
		description
	]
	current_choice_id +=1
	$Panel_ButtonGeneration/ScrollContainer_CodePreview_ChoicePreview/VScrollBar_CodePreview/Label.text = str(TemporaryChoices)
	$Panel_ButtonGeneration/ScrollContainer_CodePreview_ChoicePreview/VScrollBar_CodePreview/Label.autowrap_mode = true
