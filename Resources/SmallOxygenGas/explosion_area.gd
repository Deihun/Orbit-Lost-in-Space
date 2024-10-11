extends Area2D
@export var explosion_force : float = 2000.0

func _ready() -> void:
	print("EXPLOSION START")
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	print("gumagana and its name ", body.name ," ", body is RigidBody2D)
	if body is RigidBody2D:
		var direction = body.global_position - global_position
		direction = direction.normalized()
		
		var force = direction * explosion_force
		body.apply_central_force(force)
		


func _on_timer_timeout() -> void:
	print("EXPLOSION END")
	queue_free()
