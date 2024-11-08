extends Label
func _ready() -> void:
	hide()

# Called when the node enters the scene tree for the first time.
func trigger(value : int):
	$".".text = str("-", value,"S")
	$AnimationPlayer.play("Trigger")
