extends Sprite2D
@onready var interaction_area =  $Keycard/InteractionArea


func _ready() -> void:
	interaction_area.interact = Callable(self,"interaction")

func interaction():
	$"../DoorWay".open_door()
	$Keycard.queue_free()
