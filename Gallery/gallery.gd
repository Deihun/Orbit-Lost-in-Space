extends Control

var addgallery = preload("res://Gallery/gallery_button.tscn")

var gallery_path = "res://Gallery/gallery.json"
var images = []
var boolcheck = []

func _ready() -> void:
	get_data_gallery()
	instace_button_to_grid()
	
func get_data_gallery() -> void:
	var file = FileAccess.open(gallery_path, FileAccess.READ) 
	var json_data = file.get_as_text() 
	var json = JSON.new()
	var parse_result = json.parse(json_data)
	var result = json.get_data()
	
	images = result["images"]
	#print(images)
	for i in images:
		if i["unlocked"]:
			print(i)
			#ayoko na
		#print(i)
		#print(boolcheck)
	
func set_data_gallery() -> void:
	pass

func set_gallery_unlocked() -> void:
	pass
	
func get_boolcheck() -> void:
	pass
	
func instace_button_to_grid() -> void:
	for i in images.size():
		var Gnode = addgallery.instantiate()
		#Gnode.getbool = images[i][0]
		#Gnode.getID = images[i][i][i]
		$NinePatchRect/GalleryPanel/GridContainer.add_child(Gnode)
	
