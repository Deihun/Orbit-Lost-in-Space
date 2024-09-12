extends RigidBody2D
@export var friction : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_rotation = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var colliding_bodies = get_colliding_bodies()
	print("COLLIDING: ",colliding_bodies)
	for Body in colliding_bodies:
		var direction = (global_position - Body.global_position).normalized()
		apply_impulse(direction * 0.000000001)  # Adjust force value as needed
	
	var velocity = state.linear_velocity
	var friction_force = velocity.normalized() * -friction
	apply_impulse(friction_force)
