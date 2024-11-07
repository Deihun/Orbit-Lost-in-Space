extends Control


func _on_button_add_button_up() -> void:
	var a = preload("res://Scripts/_probability_index.tscn").instantiate()
	$Panel/ScrollContainer/VBoxContainer.add_child(a)


func get_value():
	var array = []
	for child in $Panel/ScrollContainer/VBoxContainer.get_children():
		array.append(child.get_value())
		child.queue_free()
	return array

func canBeCall()-> bool:
	return $Panel/ScrollContainer/VBoxContainer.get_child_count() > 0


func _on_button_clear_button_up() -> void:
	for child in $Panel/ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
		
