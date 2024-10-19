extends Control

var _maxim = load("res://Resources/CREW/MAXIM.png")
var _regina = load("res://Resources/CREW/REGINA PICK UP.png")
var _fumiko = load("res://Resources/CREW/REGINA PICK UP.png")
var _nashir = load("res://Resources/CREW/REGINA PICK UP.png")
var _nonOccupy = load("res://Resources/CREW/NotOccupy.png")
var inventory

func _ready() -> void:
	pass
	#await get_tree().create_timer(0.5)
	#updateUI()

func _process(delta):
	if not inventory: #This recursion ensure that the pathing is called correctly 
		inventory = NodeFinder.find_node_by_name(get_tree().current_scene, "ResourceUI_InRun")
		if inventory: 
			updateUI()
			set_process(false)  #Stop the recursion at all of this object



func updateUI():
	var container = $Crew_container
	var presetSize = Vector2(0.5,0.5)
	var sprite1 = Sprite2D.new()
	var sprite2 = Sprite2D.new()
	var sprite3 = Sprite2D.new()
	var sprite4 = Sprite2D.new()
	var control1 = Control.new()
	var control2 = Control.new()
	var control3 = Control.new()
	var control4 = Control.new()
	
	for children in container.get_children():
		container.remove_child(children)
	
	if inventory.crew["regina"] == true: 
		print("dito na ba si regina?")
		sprite1.texture = _regina
		sprite1.scale = presetSize
		container.add_child(control1)
		control1.add_child(sprite1)
	if inventory.crew["fumiko"] == true: 
		sprite2.texture = _fumiko
		sprite2.scale = presetSize
		container.add_child(control2)
		control2.add_child(sprite2)
	if inventory.crew["nashir"] == true: 
		sprite3.texture = _nashir
		sprite3.scale = presetSize
		container.add_child(control3)
		control3.add_child(sprite3)
	if inventory.crew["maxim"] == true: 
		sprite4.texture = _maxim
		sprite4.scale = presetSize
		container.add_child(control4)
		control4.add_child(sprite4)
	
	print("CREW UNOCCUPIED",inventory.crew_availability)
	for i in inventory.crew_availability:
		var a = Control.new()
		var b = Sprite2D.new()
		b.texture = _nonOccupy
		b.scale = Vector2(0.25,0.25)
		container.add_child(a)
		a.add_child(b)
