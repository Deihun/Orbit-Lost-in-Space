extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var start_game = preload("res://Scenes/LoadingScene.tscn") as PackedScene
		get_tree().change_scene_to_packed(start_game)
