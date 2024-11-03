extends Node

@onready var button_sfx: AudioStreamPlayer = $"../../ButtonSfx"

func _on_tab_container_tab_changed(tab: int) -> void:
	button_sfx.play()
