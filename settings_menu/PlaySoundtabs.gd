extends Node

@onready var button_sfx: AudioStreamPlayer = $"../../ButtonSfx"

func _on_graphics_visibility_changed() -> void:
	button_sfx.play()

func _on_visibility_changed() -> void:
	button_sfx.play()

func _on_controls_visibility_changed() -> void:
	button_sfx.play()

func _on_general_visibility_changed() -> void:
	button_sfx.play()
