extends Node2D


@onready var worldTimer = NodeFinder.find_node_by_name(get_tree().current_scene,"")
var fadingOut : bool = false
var transparency : float = 0.0
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	visible = true
	$LastMinuteBlinking.start()
	pass


func _on_last_minute_blinking_timeout() -> void:
	if fadingOut:
		$Sprite2D.modulate = Color(1,1,1, transparency)
		transparency -= 0.2
		fadingOut = !(transparency <= 0.0)
		pass
	else:
		$Sprite2D.modulate = Color(1,1,1, transparency)
		transparency += 0.2
		fadingOut = !(transparency <= 1.0)
		pass
	$LastMinuteBlinking.start()
	pass # Replace with function body.
