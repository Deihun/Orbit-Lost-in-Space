extends Control


# Called when the node enters the scene tree for the first time.


func _on_button_clear_hidden_choice_button_up() -> void:
	queue_free()


func get_value():
	var quantity
	if !$HiddenChoice_Panel/HiddenChoice_Quantity.visible: quantity = null
	else: quantity = int($HiddenChoice_Panel/HiddenChoice_Quantity.text)
	var mainArray = [$HiddenChoice_Panel/OptionBox_HiddenChoice_Condition.text, [$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.text,quantity ]]
	return mainArray


func _on_option_box_hidden_choice_condition_item_selected(index: int) -> void:
	$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.clear()
	match index:
		0:
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("SPAREPARTS",0)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("FOOD",1)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("BIOGENE",2)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("GAS",3)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("FUEL",4)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("MEDKIT",5)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("DUCTAPE",6)
			$HiddenChoice_Panel/HiddenChoice_Quantity.show()
		1:
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("SPUTNIK",0)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("STRANGEPURPLECACTUS",1)
			#$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("RE",2)
			#$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("GAS",3)
			#$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("FUEL",4)
			#$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("MEDKIT",5)
			#$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("DUCTAPE",6)
			$HiddenChoice_Panel/HiddenChoice_Quantity.hide()
		2:
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("Maxim",0)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("Nashir",1)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("Regina",2)
			$HiddenChoice_Panel/OptionChoice_HiddenChoice_Condition.add_item("Fumiko",3)
			$HiddenChoice_Panel/HiddenChoice_Quantity.hide()
			pass
