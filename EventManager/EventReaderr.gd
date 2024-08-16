extends Node
								#THIS SCRIPT IS ASSIGN TO ANDREI AND HAS NO PROPER ASSIGN COMMENTS YET
var events = []
var event_ui_instance
@onready var Title = $Title
@onready var Description = $Description2


func _ready():
	#print("initializing")
	var file_path = "res://Scripts/Events.json"
	if(FileAccess.file_exists(file_path)):
		var file = FileAccess.open(file_path,FileAccess.READ)
		var json_text = file.get_as_text()
		print("Found Json file")
		events = parse_json(json_text)
	else: 
		print("Failed to locate")
	process_random_event()

func parse_json(json_text):
	var json = JSON.new()
	var result = json.parse(json_text)
	if result != OK:
		print("Failed to parse JSON at line ", json.get_error_line())
		return []
	print("Test Event Reading Success!")
	return json.get_data()
	
func process_random_event():
	print("Triggered Successfully!")
	var event_index_random = randi() % events.size()
	var event = events[event_index_random]
	process_event(event)
	

func process_event(event):
	if (event["RandomTrue"] != true): #check if not supporting event
		process_random_event()
		return
	var name = event["name"]
	var description = event["description"]
	var return_values = event["return"]
	var follow_up = event["followUp"]
	var oxygen = return_values[0]
	var fuel = return_values[1]
	var sparepart = return_values[2]
	var chemical = return_values[3]
	var food_ration = return_values[4]
	var Item_transfer = return_values[5]
	printEventTitle(name,description)
	
	
	
	if follow_up[0] != 0:
		match follow_up.size():
			0:
				trigger_follow_up_event(follow_up)
			1:
				double_choice(event)
			2:
				triple_choice(event)
			3:
				quadra_choice(event)


func printEventTitle(title, description):
	Title.clear()
	Title.add_text(title)
	Description.clear()
	Description.add_text(description)


func double_choice(event):
	print("d choice")
func triple_choice(event):
	print("c choice")
func quadra_choice(event):
	print("q choice")

func trigger_follow_up_event(follow_up):
	for event in events:
		if event["name"] == follow_up:
			process_event(event)
			break
	singleChoiceButton()


func singleChoiceButton():
	var event_ui_instance = get_node("Event_UI")
	var button1 = event_ui_instance.get_node("Button_1")
	var button2 = event_ui_instance.get_node("Button_2")
	var button3 = event_ui_instance.get_node("Button_3")
	button1.visibility = true
	button2.visibility = false
	button3.visibility = false

func doubleChoiceButton(button_1_name, button_2_name):
	var event_ui_instance = get_node("Event_UI")
	var button1 = event_ui_instance.get_node("Button_1")
	var button2 = event_ui_instance.get_node("Button_2")
	var button3 = event_ui_instance.get_node("Button_3")
	button1.visibility = true
	button2.visibility = true
	button3.visibility = false

func tripleChoice(button_1_name, button_2_name):
	var event_ui_instance = get_node("Event_UI")
	var button1 = event_ui_instance.get_node("Button_1")
	var button2 = event_ui_instance.get_node("Button_2")
	var button3 = event_ui_instance.get_node("Button_3")
	button1.visibility = true
	button2.visibility = true
	button3.visibility = false

func test():
	print("gumagana")
func _process(delta):
	pass
