extends Control

var positive = load("res://Scenes/Cycle_Report/Positive.tres")
var negative = load("res://Scenes/Cycle_Report/Negative.tres")
var icon_negative = load("res://Scenes/Cycle_Report/Subtraction.png")
var icon_positive = load("res://Scenes/Cycle_Report/Addition.png")

func set_data(description : String):
	if description.contains("-"):
		$Panel.add_theme_stylebox_override("panel",negative)
		$Icon_Sign.texture = icon_negative
		pass
	elif description.contains("has gone missing..."):
		$Panel.add_theme_stylebox_override("panel",negative)
		var split = description.split(" ")
		description = split[0] + " has gone missing..."
	else: 
		$Panel.add_theme_stylebox_override("panel",positive)
		$Icon_Sign.texture = icon_positive
		pass
	$CycleReportBar_Label_Description.text = str(description)
	pass
