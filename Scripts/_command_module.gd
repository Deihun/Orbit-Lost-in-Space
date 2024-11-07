extends Control


func get_value():
	var array = []
	for child in $Panel/Command_CollectionPanel/ScrollContainer/VBoxContainer.get_children():
		array.append(child.get_value())
	return array

func _on_command_collection_panel_add_button_up() -> void:
	var a = preload("res://Scripts/commands_index.tscn").instantiate()
	$Panel/Command_CollectionPanel/ScrollContainer/VBoxContainer.add_child(a)


func _on_command_collection_panel_clear_button_up() -> void:
	print(get_value())
	for child in $Panel/Command_CollectionPanel/ScrollContainer/VBoxContainer.get_children():
		child.queue_free()

func canBeUsed()-> bool:
	return $Panel/Command_CollectionPanel/ScrollContainer/VBoxContainer.get_child_count() > 0
