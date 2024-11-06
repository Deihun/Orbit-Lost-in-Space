extends Control
var array = []
var hiddenChoice = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CheckButton/Panel_HiddenChoiceButton.hide()

func get_value():
	if $CheckButton.is_pressed():
		getHiddenChoiceValue()
		array = [
			hiddenChoice, #HiddenChoiceArray
			[int($LineEdit_CreateChoiceButton_ID.text) , #ID 
			[[$OptionButton.text , int($"LineEdit_ChoiceButton_ Amount".text)]],
			$RichTextLabel.text
			]] #ItemType & Amount
	else:
		array = [int($LineEdit_CreateChoiceButton_ID.text) , #ID 
			[[$OptionButton.text , int($"LineEdit_ChoiceButton_ Amount".text)]]
			,$RichTextLabel.text]
	return array

func getHiddenChoiceValue():
	var child_node = $CheckButton/Panel_HiddenChoiceButton/ScrollContainer/VBoxContainer.get_child(0)
	hiddenChoice = child_node.get_value().duplicate()


func _on_exit_button_button_up() -> void:
	print(get_value())
	#self.queue_free() #Testing for now


func _on_check_button_toggled(toggled_on: bool) -> void:
	$CheckButton/Panel_HiddenChoiceButton.visible = toggled_on


func _on_button_add_hidden_choice_button_up() -> void:
	var _hidden = preload("res://Scripts/hidden_choice.tscn").instantiate()
	_hidden.name = "HiddenChoice-1"
	$CheckButton/Panel_HiddenChoiceButton/ScrollContainer/VBoxContainer.add_child(_hidden)



func _on_button_add_hidden_choice_2_button_up() -> void:
	for child in $CheckButton/Panel_HiddenChoiceButton/ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
