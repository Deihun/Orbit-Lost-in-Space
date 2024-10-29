extends Control

var space_facts: Array = []
var unlocked_facts: Array = []

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	load_facts()
	print("Space facts loaded:", space_facts.size()+1)

# Loads the space facts from the JSON file
func load_facts():
	var file = FileAccess.open("res://SpaceFacts/space_facts.json", FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		var json = JSON.new()
		var parse_result = json.parse(json_data)
		
		# Check for parsing error and retrieve parsed result
		if parse_result == OK:
			var parsed_data = json.data
			space_facts = parsed_data["facts"]
		else:
			print("Failed to parse JSON: Error Code", parse_result)
		file.close()
	else:
		print("Error opening JSON file.")

# Checks if a fact has been encountered
func has_encountered(fact_id: String) -> bool:
	for fact in space_facts:
		if fact.get("id") == fact_id:
			return fact.get("encountered", false)
	return false

# Unlocks a fact by marking it as encountered and adds it to unlocked_facts
func unlock_facts(fact_id: String) -> void:
	for fact in space_facts:
		if fact["id"] == fact_id:
			if not fact.get("encountered", false):
				fact["encountered"] = true
				unlocked_facts.append(fact)
				print("Fact unlocked:", fact["text"])
			break

# Returns a list of unlocked facts' texts for FactViewer
func get_unlocked_facts() -> Array:
	var facts_texts = []
	for fact in unlocked_facts:
		facts_texts.append(fact.get("text", "No fact available."))
	return facts_texts 

# Retrieves a fact by ID if encountered, otherwise returns "Not Found"
func get_fact(fact_id: String) -> String:
	for fact in space_facts:
		if fact.get("id") == fact_id and fact.get("encountered", false):
			return fact.get("text", "No fact found.")
	return "Not Found."
