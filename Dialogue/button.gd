extends BaseDialogueTestScene

func action() -> void:
	var balloon = load("res://Dialogue/balloon.tscn").insantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(resource, title)
