extends CharacterBody2D

var vZeros = Vector2.ZERO
var maxSpeed = 200.0
var Friction = 1000.0
var inventory


#VOID METHODS
func _ready():	#OnStart, 
	inventory = get_parent().get_node("player/AllUIParents/UI_On_Hand")


func _physics_process(delta):
	var input_vector = Vector2.ZERO #initialize vector value
	
	#ADD VALUES TO VECTOR WHENEVER INPUT IS PRESS BETWEEN POSITIVE AND NEGATIVE
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() #Normalizes the vector to make equal vector whenever moving on slant directions
	
	#CHECK IF VECTOR IS 'NOT' NULL OR ZERO TO MOVE ON SPECIFIC CALCULATION, SET ZERO OTHERWISE LATTER
	if input_vector != Vector2.ZERO: 
		velocity = input_vector * (maxSpeed + inventory.getSpeedPenalty()) * (delta*100)
	else:
		velocity = vZeros.move_toward(Vector2.ZERO, Friction * delta)
	move_and_slide()


func update_label(text_content, isColor): #Set the child label node 
	var label = get_parent().get_node("player/AllUIParents/Label")
	label.text = str(text_content)

