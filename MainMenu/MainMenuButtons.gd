extends Node2D

func _on_button_pressed(): #OnStart, start the testingScene
	get_tree().change_scene_to_file("res://Player/testing.tscn")
