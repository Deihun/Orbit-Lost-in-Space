extends CharacterBody2D
var vZeros = Vector2.ZERO
var maxSpeed = 300.0
var slow = 0.0
var Friction = 1000.0
var inventory
var isPicking = false
var distanceCurrentLimit = 0
var canMove = false
var endAnimationOnce = true
var isPickingAnim : bool = false
var currentAnimation = ""
@onready var anim_player = $Player4
@onready var PickupTimer = $PickUpCooldown


#VOID METHODS
func _ready():	#OnStart, 
	play_animation("Idle_animation")
	$AllUIParents/Label_Timer.visible = false
	distanceCurrentLimit = 0
	inventory = get_parent().get_node("player/AllUIParents/UI_On_Hand")


func _physics_process(delta):
	if !isPicking and canMove:
		movement(delta)
	
	
	

func movement(delta):
	var animationFramesSlowness = (24 - (3 - (((maxSpeed - slow + inventory.getSpeedPenalty()))/50)))/24
	if animationFramesSlowness > 1.0:
		animationFramesSlowness= 1.0
	if isPickingAnim:
		return
	var input_vector = Vector2.ZERO #initialize vector value
	#ADD VALUES TO VECTOR WHENEVER INPUT IS PRESS BETWEEN POSITIVE AND NEGATIVE
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() #Normalizes the vector to make equal vector whenever moving on slant directions
	
	if input_vector != Vector2.ZERO:
		distanceCurrentLimit += 1 if distanceCurrentLimit < 51 else 0
		removeTutorialUI_onCertainCondition()
		velocity = input_vector * ((maxSpeed - slow) + inventory.getSpeedPenalty()) * (delta * 100)
		if input_vector.x > 0:
			play_animation("Right_movement")
		elif input_vector.x < 0:
			play_animation("Left_animation")
		elif input_vector.y > 0:
			play_animation("Down_Movement")
		elif input_vector.y < 0:
			play_animation("Up_animation")
	elif !isPickingAnim and input_vector == Vector2.ZERO:
		velocity = vZeros.move_toward(Vector2.ZERO, Friction * delta)
		play_animation("Idle_animation") # Play idle animation when not moving    
	
	if (Vector2.ZERO == input_vector && currentAnimation != "Idle_animation"):
		isPickingAnim = false
	#CHECK IF VECTOR IS 'NOT' NULL OR ZERO TO MOVE ON SPECIFIC CALCULATION, SET ZERO OTHERWISE LATTER
	if input_vector != Vector2.ZERO: 
		distanceCurrentLimit += 1 if distanceCurrentLimit < 51 else 0
		removeTutorialUI_onCertainCondition()
		velocity = input_vector * ((maxSpeed - slow) + inventory.getSpeedPenalty()) * (delta*100)
	else:
		velocity = vZeros.move_toward(Vector2.ZERO, Friction * delta)
	anim_player.speed_scale = animationFramesSlowness
	move_and_slide()

func pickup():
	if currentAnimation != "Pickup_animation":
		isPickingAnim = true
		isPicking = true
		play_animation("Pickup_animation")

func update_label(text_content, isColor): #Set the child label node 
	var label = get_parent().get_node("player/AllUIParents/Label_Timer")
	if !$AllUIParents/Globe_Timer_Sprite/Meteor_animated.is_playing():
		$AllUIParents/Globe_Timer_Sprite/Meteor_animated.play("idle_meteor")
	$AllUIParents/Globe_Timer_Sprite/Meteor_animated.rotate(0.03)
	label.text = str(text_content)

func play_animation(anim_name):
	if currentAnimation != anim_name:
		currentAnimation = anim_name
		anim_player.stop()
		anim_player.play(anim_name)
	

func _on_player_4_animation_finished() -> void:
	if currentAnimation == "Pickup_animation":
		isPickingAnim = false
		isPicking = false
		anim_player.play("Idle_animation")
	pass # Replace with function body.

func _on_pause_button_button_down() -> void:
	var pause = $AllUIParents/PauseMenu
	pause._pause()


func ReadyToRun() -> void:
	isPicking = false


func removeTutorialUI_onCertainCondition():
	pass

func gameStart():
	startUI()
	pass
	
func startUI():
	$AllUIParents/StartUI_label.visible = true
	await get_tree().create_timer(0.1).timeout 
	$AllUIParents/StartUI_label.visible = false
	await get_tree().create_timer(0.1).timeout 
	$AllUIParents/StartUI_label.visible = true
	await get_tree().create_timer(0.1).timeout 
	$AllUIParents/StartUI_label.visible = false
	await get_tree().create_timer(0.1).timeout 
	$AllUIParents/StartUI_label.visible = true
	await get_tree().create_timer(1.5).timeout 
	$AllUIParents/StartUI_label.visible = false
	$AllUIParents/Label_Timer.visible = true
	$AllUIParents/Globe_Timer_Sprite.visible =true
	$AllUIParents/Globe_Timer_Sprite/Meteor_animated.visible= true
	$AllUIParents/UI_On_Hand.visible = true
	$AllUIParents/TutorialAssets.visible = true
	$AllUIParents/ResourceUI_InRun.visible = true
	canMove = true
	var timer = NodeFinder.find_node_by_name(get_tree().current_scene, "countDown_mainTimer")
	timer.GameStart()
	pass

func endScene():
	canMove = false
	if endAnimationOnce:
		$AllUIParents/BlackTransition.play("default")
		$AllUIParents/BlackTransition.visible = true
		endAnimationOnce = false
	await get_tree().create_timer(5).timeout 
	$AllUIParents/Red_UI_Indicator.visible = false
	$AllUIParents/BlackTransition.visible = false
	$AllUIParents/UI_On_Hand.visible = false
	$AllUIParents/Label_Timer.visible =false
	$AllUIParents/Globe_Timer_Sprite.visible = false
	$AllUIParents/Globe_Timer_Sprite/Meteor_animated.visible = false
	$AllUIParents/Label_Timer.visible = false
	var introCam = NodeFinder.find_node_by_name(get_tree().current_scene, "IntroductionCamera")
	introCam.position = Vector2(4000,-3800)
	introCam.make_current()
	await get_tree().create_timer(3).timeout 
	IngameStoredProcessSetting.Scenes = "interiorscene"
	get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
	pass


func _on_checking_for_on_hit_effect_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		slow = 50.0
	pass # Replace with function body.


func _on_checking_for_on_hit_effect_body_exited(body: Node2D) -> void:
	if body is RigidBody2D:
		slow = 0.0
	pass # Replace with function body.
