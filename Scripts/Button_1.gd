extends Button


func _ready():
	pass # Replace with function body.



func _on_pressed():
	var root_node = get_tree().root.get_child(0)
	root_node.process_random_event()
