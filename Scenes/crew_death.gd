extends ColorRect


func setText():
	var r = IngameStoredProcessSetting
	var message : String = r.deathMessage 
	$NinePatchRect/Label.text = message
	r.deathMessage = ""




func _on_back_button_up() -> void:
	queue_free()
