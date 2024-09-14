extends CharacterBody2D

var vZeros = Vector2.ZERO
var maxSpeed = 200.0
var Friction = 1000.0
var inventory
var isPicking = false
var distanceCurrentLimit = 0
@onready var PickupTimer = $PickUpCooldown


#VOID METHODS
func _ready():	#OnStart, 
	$AllUIParents/Label_Timer.visible = false
	distanceCurrentLimit = 0
	inventory = get_parent().get_node("player/AllUIParents/UI_On_Hand")


func _physics_process(delta):
	if !isPicking:
		movement(delta)
	
	if Input.is_action_just_pressed("Interact"):
		isPicking = true
		PickupTimer.start()
	
	

func movement(delta):
	var input_vector = Vector2.ZERO #initialize vector value
	
	#ADD VALUES TO VECTOR WHENEVER INPUT IS PRESS BETWEEN POSITIVE AND NEGATIVE
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() #Normalizes the vector to make equal vector whenever moving on slant directions
	
	#CHECK IF VECTOR IS 'NOT' NULL OR ZERO TO MOVE ON SPECIFIC CALCULATION, SET ZERO OTHERWISE LATTER
	if input_vector != Vector2.ZERO: 
		distanceCurrentLimit += 1 if distanceCurrentLimit < 51 else 0
		removeTutorialUI_onCertainCondition()
		velocity = input_vector * (maxSpeed + inventory.getSpeedPenalty()) * (delta*100)
	else:
		velocity = vZeros.move_toward(Vector2.ZERO, Friction * delta)
		
	move_and_slide()

func update_label(text_content, isColor): #Set the child label node 
	var label = get_parent().get_node("player/AllUIParents/Label_Timer")
	label.text = str(text_content)


func _on_pause_button_button_down() -> void:
	var pause = $AllUIParents/PauseMenu
	pause._pause()


func ReadyToRun() -> void:
	isPicking = false


func removeTutorialUI_onCertainCondition():
	if(distanceCurrentLimit > 50):
		var timer = NodeFinder.find_node_by_name(get_tree().current_scene, "countDown_mainTimer")
		timer.GameStart()
	pass

func gameStart():
	$AllUIParents/Label_Timer.visible = true
	pass
