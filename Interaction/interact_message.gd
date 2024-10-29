extends Node2D
@export_group("Message")
@export_subgroup("Message Content")
@export var message : String = "Enter here"
@export_subgroup("Property")
@export var offset : Vector2
@export var _timer_ : bool = true
@export var seconds : int = 5

@export_group("Collision")
@export var collision_scale : Vector2 = Vector2(1,1)
@onready var interaction_area = $InteractionArea


func _ready() -> void:
	$InteractionArea/CollisionShape2D.scale = collision_scale
	$Timer.wait_time = seconds
	interaction_area.interact = Callable(self,"interaction")


func interaction():
	$Panel/Message.text = message
	open()
	if _timer_: $Timer.start()

func open():
	self.show()

func close():
	self.hide()
	pass

func _on_timer_timeout() -> void:
	close()
