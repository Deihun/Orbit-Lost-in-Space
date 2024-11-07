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
	for fact in rawFacts:
		if fact["id"] == fact_id:
			if not fact["encountered"]: # Only update if not already encountered
				fact["encountered"] = true
				condition = true
			gallerydata()
		#LoopChecker()
	
func savegallery():
	print("saved")
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var json_string = JSON.stringify(gallerydata())
	file.store_line(json_string)
	
func loadgallery():
	if not FileAccess.file_exists(file_path):
		print("file exsit")
		return
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()	
	
func _on_button_pressed() -> void:
	self.hide()
