extends Button
#THIS SCRIPT IS JUST LITERALLY SHIT, DONT MIND IT FOR NOW, IT WILL BE CHANGE LATER AS PART OF MAIN MENU TAS_K ASSIGN TO ANG

func _ready():
	pass # Replace with function body.



func _on_pressed():
	var root_node = get_tree().root.get_child(0)
	root_node.process_random_event()
