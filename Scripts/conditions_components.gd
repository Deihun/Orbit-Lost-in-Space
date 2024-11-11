extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on__use_condition_check_button_toggled(false)
	pass # Replace with function body.





func _on__use_condition_check_button_toggled(toggled_on: bool) -> void:
	$Panel/Conditional_OptionButton.visible = toggled_on
	$Panel/Condition_Value_LineText.visible = toggled_on
	pass # Replace with function body.
