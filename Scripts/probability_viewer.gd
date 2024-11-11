extends Panel


# Called when the node enters the scene tree for the first time.
func set_probability(probability):
	$InProbability.text = str(" /",probability)

func add_view_command(command):
	var a = Label.new()
	a.text = str(command)
	$ScrollContainer/VBoxContainer.add_child(a)
