extends Control

func _ready() -> void:
	_on_condition_option_button_item_selected(0)

func _on_condition_option_button_item_selected(index: int) -> void:
	match index:
		0:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.show()
		1:
			$Panel/Value_OptionButton.clear()
			$Panel/Value_OptionButton.show()
			$Panel/Quantity_LineEdit.show()
			$Panel/Value_LineText.hide()
			$Panel/Value_OptionButton.add_item("SPAREPARTS",0)
			$Panel/Value_OptionButton.add_item("FUEL",1)
			$Panel/Value_OptionButton.add_item("OXYGEN",0)
			$Panel/Value_OptionButton.add_item("BIOGENE",2)
			$Panel/Value_OptionButton.add_item("MEDKIT",3)
			$Panel/Value_OptionButton.add_item("DUCTAPE",4)
			$Panel/Value_OptionButton.add_item("FOOD",5)
		2:
			$Panel/Value_OptionButton.clear()
			$Panel/Value_OptionButton.show()
			$Panel/Quantity_LineEdit.show()
			$Panel/Value_LineText.hide()
			$Panel/Value_OptionButton.add_item("Maxim",0)
			$Panel/Value_OptionButton.add_item("Fumiko",1)
			$Panel/Value_OptionButton.add_item("Regina",0)
			$Panel/Value_OptionButton.add_item("Nashir",2)
		3:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.show()
		4:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.show()
		5:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.show()
		6:
			$Panel/Value_OptionButton.show()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.hide()
			$Panel/Value_OptionButton.clear()
			$Panel/Value_OptionButton.add_item("SPAREPARTS",0)
			$Panel/Value_OptionButton.add_item("FUEL",1)
			$Panel/Value_OptionButton.add_item("OXYGEN",0)
			$Panel/Value_OptionButton.add_item("BIOGENE",2)
			$Panel/Value_OptionButton.add_item("MEDKIT",3)
			$Panel/Value_OptionButton.add_item("DUCTAPE",4)
			$Panel/Value_OptionButton.add_item("FOOD",5)
		7:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.show()
		8:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.show()
		9:
			$Panel/Value_OptionButton.show()
			$Panel/Quantity_LineEdit.show()
			$Panel/Value_LineText.hide()
			$Panel/Value_OptionButton.clear()
			$Panel/Value_OptionButton.add_item("Radonti",0)
			$Panel/Value_OptionButton.add_item("Steelicus",1)
			$Panel/Value_OptionButton.add_item("Earth2.0",0)
			$Panel/Value_OptionButton.add_item("Sauria",2)
			$Panel/Value_OptionButton.add_item("AbandonShip",3)
		10:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.hide()
		11:
			$Panel/Value_OptionButton.show()
			$Panel/Quantity_LineEdit.show()
			$Panel/Value_LineText.hide()
			$Panel/Value_OptionButton.clear()
			$Panel/Value_OptionButton.add_item("Maxim",0)
			$Panel/Value_OptionButton.add_item("Regina",1)
			$Panel/Value_OptionButton.add_item("Nashir",0)
			$Panel/Value_OptionButton.add_item("Fumiko",2)
		12:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.show()
		13:
			$Panel/Value_OptionButton.show()
			$Panel/Quantity_LineEdit.show()
			$Panel/Value_LineText.hide()
			$Panel/Value_OptionButton.clear()
			$Panel/Value_OptionButton.add_item("Maxim",0)
			$Panel/Value_OptionButton.add_item("Regina",1)
			$Panel/Value_OptionButton.add_item("Nashir",0)
			$Panel/Value_OptionButton.add_item("Fumiko",2)
		14: 
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.show()
		15:
			$Panel/Value_OptionButton.hide()
			$Panel/Quantity_LineEdit.hide()
			$Panel/Value_LineText.hide()

func get_value():
	var value = $Panel/Condition_OptionButton.get_selected_id()
	var string = ""

#OnlyValueText
	if value in [0 , 3 , 4 , 5 , 7 , 8 , 12,14]:
		string = str($Panel/Condition_OptionButton.text,$Panel/Value_LineText.text)
#OptionBox andQuantity
	elif value in [1,2,9,11,13]:
		string = str($Panel/Condition_OptionButton.text,$Panel/Value_OptionButton.text," ",$Panel/Quantity_LineEdit.text)
		pass
#OnlyOptionBox
	elif value == 6:
		string = str($Panel/Condition_OptionButton.text,$Panel/Value_OptionButton.text)
	elif value in [10,15]:
		string = str($Panel/Condition_OptionButton.text)
	return string


func _on_button_remove_button_up() -> void:
	#print(get_value())
	queue_free()
