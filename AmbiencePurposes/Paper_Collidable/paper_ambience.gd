extends Area2D

@onready var animation = $AnimatedSprite2D
var a_rotation = randf()*360
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = a_rotation
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	rotation = a_rotation
	animation.play("Idle")


func _on_body_entered(body: Node2D) -> void:
	rotation = 0
	animation.play("Flying")
