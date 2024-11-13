extends Control

@export var saveNode : PackedScene
@onready var v_box_container: VBoxContainer = $NinePatchRect/MarginContainer2/ScrollContainer/VBoxContainer
@onready var naming: Control = $Naming

var Files = []
var numFiles = 0
var isSaving = false
var timer_duration = 1.5  # Duration in seconds
var elapsed_time = 0.0
var timer_active = false

# Start the custom timer
func start_custom_timer(duration: float = 1.5):
	timer_duration = duration * 200
	elapsed_time = 0
	timer_active = true
	self.set_process(true)

func _process(delta):
	if timer_active:
		# Update elapsed time using delta, which is independent of time scale
		elapsed_time += 1
		if elapsed_time >= timer_duration:
			timer_active = false
			on_custom_timer_timeout()
			self.set_process(false)

# Called when the timer finishes
func on_custom_timer_timeout():
	$NinePatchRect/Panel.hide()
	# Handle the timer timeout here

func _ready() -> void:
	isSaving = true
	check_saving()
	get_files()
	set_node()
	self.set_process(false)

func hidenodeMain():
	naming.hide()

func check_saving() -> void:
	if isSaving == true:
		naming.visible = true
	else:
		naming.visible = false

func set_node() -> void:
	var checkNum = 0
	for i in numFiles:
		var Snode = saveNode.instantiate()
		Snode.FileName = Files[i]
		Snode.name = str("Snode_", checkNum)
		v_box_container.add_child(Snode)
		checkNum += 1
		
func update_all():
	for child in v_box_container.get_children():
		child.queue_free()
	Files = []
	numFiles = 0
	get_files()
	set_node()
		
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
	visiblepause.visible = true
	self.visible = false

func _on_message_delay_timeout() -> void:
	print("start")
	$NinePatchRect/Panel.hide()
