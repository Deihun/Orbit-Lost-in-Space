extends Control
var rawFacts = []
var is_modified = false

func _ready() -> void:
	load_facts()
	set_fact_encountered("fact30")
	set_fact_encountered("fact20")
	set_fact_encountered("fact15")
	set_fact_encountered("fact21")
	set_fact_encountered("fact22")
	LoopChecker()
	
func create_button(data):
	var button = Button.new()
	$Panel/ScrollContainer/VBoxContainer.add_child(button)
	button.text = data["id"]
	var button_width = 200 
	var button_height = 50
	button.custom_minimum_size = Vector2(button_width, button_height)
	button.connect("pressed",Callable (self,"buttonPress").bind(data))
	
func buttonPress(data):
	$Panel/FactTitle.text = data["id"]
	$Panel/FactDesc.text = data["text"]
func LoopChecker():
	for facts in rawFacts:
		if facts["encountered"]:
			create_button(facts)
			print("testing")
		print("Fact encountered:" + facts["id"]) # print("data")
	
	
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
	for fact in rawFacts:
		if fact["id"] == fact_id:
			if not fact["encountered"]: # Only update if not already encountered
				fact["encountered"] = true
			print("Setting encountered for fact:",fact_id)
			save_facts_to_json()
		else:
			print("fact already marked as encountered:", fact_id)
			
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
		
