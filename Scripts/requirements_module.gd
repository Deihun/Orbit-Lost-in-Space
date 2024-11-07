extends Control




func _on_requirements_remove_button_up() -> void:
	self.queue_free()

func get_value():
	var array = [$Panel/OptionButton.text, int($"Panel/LineEdit_ChoiceButton_ Amount".text)]
	if $"Panel/LineEdit_ChoiceButton_ Amount".text == "" or null:
		return []
	return array
	
