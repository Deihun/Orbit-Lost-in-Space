extends Sprite2D


@onready var interaction_area =  $KeyCard/InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self,"interaction")

func interaction():
	$"../DoorWay3".open_door()
	$KeyCard.queue_free()
