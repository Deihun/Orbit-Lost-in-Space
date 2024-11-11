extends Panel


func id(id):
	$ID_.text = str("ID ",id)

func description(desc):
	$Description.text = desc

func add_requirement(name):
	$HasNoRequirements.hide()
	var label = Label.new()
	label.text = str(name)
	$Requirements/VBoxContainer.add_child(label)
