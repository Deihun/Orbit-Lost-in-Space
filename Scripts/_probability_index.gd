extends Control
var array_ = []



func _on_button_remove_button_up() -> void:
	queue_free()


func _on_button_button_up() -> void:
	var a = preload("res://Scripts/command_index_in_probability.tscn").instantiate()
	$ScrollContainer/VBoxContainer.add_child(a)

func get_value():
	getCompileCommand()
	var array = [
		int($LineEdit.text), array_
	]
	return array

func getCompileCommand():
	for child in $ScrollContainer/VBoxContainer.get_children():
		array_.append(child.get_value())


func _on_label_clear_button_up() -> void:
	for child in $ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
