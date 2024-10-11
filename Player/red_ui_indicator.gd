extends Node2D

var transparency : float = 1.0
var adding : float = false

func _on__red_ui_indicator_timer_timeout() -> void:
	if adding:
		$Red.modulate.a += 0.1
		if $Red.modulate.a >= 1.0:
			adding = false
	else:
		$Red.modulate.a -= 0.1 
		if $Red.modulate.a <= 0.0:
			adding = true
	
