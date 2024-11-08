extends Control

var addgallery = preload("res://Gallery/gallery_button.tscn")
var result
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
	result = json.get_data()
	
	images = result["images"].duplicate()
	for i in images:
		pass
		if i["unlocked"]:
			pass

func set_data_gallery() -> void:
	pass

func set_gallery_unlocked() -> void:
	pass
	
func get_boolcheck() -> void:
	pass
	
func instace_button_to_grid() -> void:
	for i in images:
		var Gnode = addgallery.instantiate()
		$NinePatchRect/GalleryPanel/GridContainer.add_child(Gnode)
		print(i["unlocked"])
		if i["unlocked"]: 
			Gnode.set_image(i["id"])


func _on_button_button_up() -> void:
	queue_free()
