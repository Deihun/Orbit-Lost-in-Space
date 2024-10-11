extends Area2D




func _on_mouse_entered() -> void:
	$Spareparts.visible = true
	$Spareparts.text =  str("Spareparts:", GlobalResources.spareparts)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	$Spareparts.visible = false
	pass # Replace with function body.
