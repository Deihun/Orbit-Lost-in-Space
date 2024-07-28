extends CharacterBody2D
var v = Vector2.ZERO
var maxSpeed = 100.0
var Friction = 1000.0

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * maxSpeed * (delta*100)
	else:
		velocity = v.move_toward(Vector2.ZERO, Friction * delta)
	move_and_slide()

