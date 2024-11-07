extends Control

var file_path = "res://Gallery/gallery.json"

func _ready():
	pass
	
func gallerydata():
	var images = {
		#Set Gallery data values
		"id" : "image",
		"unlocked" : false
	}
	return images
	
func set_image_unlocked(image_id):
	var condition : bool = false
	for image in rawImage:
		if image["id"] == image_id:
			if not fact["unlocked"]: # Only update if not already encountered
				image["unlocked"] = true
				condition = true
			gallerydata()
		#LoopChecker()
	
func savegallery():
	print("saved")
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var json_string = JSON.stringify(gallerydata())
	file.store_line(json_string)
	
func load_facts():
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
	
func _on_button_pressed() -> void:
	self.hide()
