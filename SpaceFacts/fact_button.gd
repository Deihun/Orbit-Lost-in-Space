extends Control
var rawFacts = []
var is_modified = false

func _ready() -> void:
	load_facts()
	LoopChecker()
	
func create_button(data):
	var button = Button.new()
	var style_normal = preload("res://SpaceFacts/FactButton_Normal.tres")
	var style_hover = preload("res://SpaceFacts/FactButton_Hover.tres")
	var black_color = Color(0, 0, 0)
	
	$Panel/ScrollContainer/VBoxContainer.add_child(button)
	button.text = data["title"]
	var button_width = 600
	var button_height = 100
	button.custom_minimum_size = Vector2(button_width, button_height)
	button.add_theme_stylebox_override("normal", style_normal)
	button.add_theme_stylebox_override("hover", style_hover)
	button.add_theme_color_override("font_color", black_color)
	button.add_theme_font_size_override("font_size", 35)
	button.connect("pressed",Callable (self,"buttonPress").bind(data))
	
func buttonPress(data):
	$Panel/FactTitle.text = data["title"]
	$Panel/FactDesc.text = data["text"]

func LoopChecker():
	for child in $Panel/ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
	
	for facts in rawFacts:
		if facts["encountered"]:
			create_button(facts)
		#print("Fact encountered:" + facts["id"]) # print("data")
	
	
func load_facts():
	var file_path = "res://SpaceFacts/space_facts.json"
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var json_text = file.get_as_text()
		var parsed_data = parse_json(json_text)
		if "facts" in parsed_data:
			rawFacts = parsed_data["facts"]
		else:
			print("EVENT-HANDLER-SCRIPT://  'load_facts' : 'No key `facts` in parsed data'")
	else: 
		print("EVENT-HANDLER-SCRIPT://  'func _ready()' : 'Failed to locate'")

func parse_json(json_text):
	var json = JSON.new()
	var result = json.parse(json_text)
	if result != OK:
		print("EVENT-HANDLER-SCRIPT://  'parse_json' : 'Failed to analyze json file'", json.get_error_line())
		return {}
	return json.get_data()
	
func set_fact_encountered(fact_id):
	var condition : bool = false
	for fact in rawFacts:
		if fact["id"] == fact_id:
			if not fact["encountered"]: # Only update if not already encountered
				fact["encountered"] = true
				condition = true
			save_facts_to_json()
		LoopChecker()
	
	var FactButton_Button_Icon = NodeFinder.find_node_by_name(get_tree().current_scene,"FactButton_Button_Icon")
	if FactButton_Button_Icon and condition:
		FactButton_Button_Icon.texture = load("res://Scenes/Ingame/FactButton_withnotif.png")


func save_if_modified():
	if is_modified:
		save_facts_to_json()
		is_modified = false # Reset after saving			

func save_facts_to_json():
	var file_path = "res://SpaceFacts/space_facts.json"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		var data_to_save = {"facts": rawFacts}
		file.store_string(JSON.stringify(data_to_save, "\t"))
		file.close()
		print("Successfully saved encountered data to JSON.")
	else:
		print("Failed to open file for writing")
		


func _on_back_button_fact_button_button_up() -> void:
	self.hide()
	pass # Replace with function body.


func _on_visibility_changed() -> void:
	LoopChecker()
	var FactButton_Button_Icon = NodeFinder.find_node_by_name(get_tree().current_scene,"FactButton_Button_Icon")
	if FactButton_Button_Icon:
		FactButton_Button_Icon.texture = load("res://Scenes/Ingame/FactButton_withoutnotif.png")
