extends Control

var dragging = false
var drag_offset = Vector2()
var id : int = 1

func set_id(_id : int):
	id = _id
	$Label.text = str("Are you sure you want do delete this ID:", id,"\nDelete data cannot be retrieve.")


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start dragging and calculate offset
				dragging = true
				drag_offset = global_position - event.global_position
			else:
				# Stop dragging
				dragging = false
	elif event is InputEventMouseMotion and dragging:
		# Calculate new position based on mouse position and offset
		var new_position = event.global_position + drag_offset

		# Get the viewport size to set boundaries
		var viewport_rect = get_viewport_rect()

		# Set limits so the Control doesn't go outside the viewport
		new_position.x = clamp(new_position.x, 0, viewport_rect.size.x - size.x)
		new_position.y = clamp(new_position.y, 0, viewport_rect.size.y - size.y)

		# Update the Control's global position within limits
		global_position = new_position


func _on_cancel_button_up() -> void:
	self.queue_free()


func _on_delete_button_up() -> void:
	var main = NodeFinder.find_node_by_name(get_tree().current_scene,"EventManagerNotIngame")
	if !main: 
		print("Delete is not successful// ERROR Cannot find EventManagerNotIngameNode")
		self.queue_free()
		return
	main.remove_data_by_id(int(id))
	self.queue_free()
