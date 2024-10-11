extends Area2D


# Called when the node enters the scene tree for the first time.


func _on_body_entered(body: Node2D) -> void:
	var group = $"../../CollectionTeddyBear"
	if group.get_child_count() == 0:
		$"..".queue_free()
	print(group.get_child_count())


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
