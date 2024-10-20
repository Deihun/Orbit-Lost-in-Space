extends BaseDialogueTestScene

func _ready() -> void:
	var balloon = load("res://DialogueSystem/balloon.tscn").instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(resource, title)
