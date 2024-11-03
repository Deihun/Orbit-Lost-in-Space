extends Control

@export var saveNode : PackedScene
@onready var v_box_container: VBoxContainer = $NinePatchRect/MarginContainer2/ScrollContainer/VBoxContainer
@onready var SaveNode = $"res://SaveAndLoad/save_node.gd"
@onready var naming: Control = $Naming
@onready var panel: Panel = $NinePatchRect/Panel

var Files = []
var numFiles = 0
var isSaving = false

func _ready() -> void:
	isSaving = true
	check_saving()
	get_files()
	set_node()

func check_saving() -> void:
	if isSaving == true:
		naming.visible = true
	else:
		naming.visible = false

func set_node() -> void:
	for i in numFiles:
		var Snode = saveNode.instantiate()
		Snode.FileName = Files[i]
		v_box_container.add_child(Snode)
		
func update_all():
	get_tree().reload_current_scene()
		
func get_files() -> void:
	var dir = DirAccess.open("res://Saves/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var base_name = file_name.get_basename()
				Files.append(base_name)
				numFiles += 1
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")

func _on_back_button_up() -> void:
	var visiblepause = NodeFinder.find_node_by_name(get_tree().current_scene, "VBoxContainer")
	if visiblepause:
		visiblepause.show()
	self.visible = false

func _on_message_delay_timeout() -> void:
	panel.hide()
