extends CharacterBody2D
var vZeros = Vector2.ZERO
var maxSpeed = 300.0
var slow : float = 0.0
var Friction : float = 1000.0
var bonusSpeed : float = 0.0

var distanceCurrentLimit :int = 0
var animation_use_id : int

var endAnimationOnce : bool = true
var isPickingAnim : bool = false
var isPicking : bool = false
var canMove : bool = false

var currentAnimation = ""

var inventory

var run_left = ["Left_animation","_Helmet_Jerry_left"]
var run_right = ["Right_movement","_Helmet_Jerry_right"]
var run_up = ["Up_animation", "_Helmet_Jerry_up"]
var run_down = ["Down_Movement","_Helmet_Jerry_down"]
var run_idle = ["Idle_animation","_Helmet_Jerry_idle"]
var run_pickup = ["Pickup_animation","_Helmet_Jerry_pickup"]

@onready var anim_player = $Player4
@onready var PickupTimer = $PickUpCooldown
@onready var player_pickup: AudioStreamPlayer = $"../PlayerPickup"
@onready var player_walk: AudioStreamPlayer = $"../PlayerWalk"
@onready var buttons: AudioStreamPlayer = $"../Buttons"

var game_over_action : Callable
var game_win : Callable



#VOID METHODS
func _ready():	#OnStart, 
	self.set_process(false)
	await get_tree().create_timer(0.1).timeout
	if $"..".useGlobeTimerUI: $AllUIParents/Timer.hide()
	else: 
		$AllUIParents/Timer/Label_Timer.text = str($"..".limitTimeDuration)
		$AllUIParents/Timer/AnimationPlayer.play("StartingAnimation")
	self.set_process(false)
	await get_tree().create_timer(0.1).timeout #For enabling animation to run on conditions
	play_animation(run_idle[animation_use_id])
	$AllUIParents/Globe_Timer_Sprite/Label_Timer.hide()
	distanceCurrentLimit = 0
	inventory = get_parent().get_node("player/AllUIParents/UI_On_Hand")
	self.set_process(true)

func _physics_process(delta):
	if !isPicking and canMove:
		movement(delta)

func movement(delta):
	bonusSpeed = bonusSpeed if bonusSpeed > 0.0 else 0.0
	var animationFramesSlowness = 1.0
	if inventory: animationFramesSlowness = (24 - (3 - (((maxSpeed - slow + inventory.getSpeedPenalty()))/50)))/24
	if animationFramesSlowness > 1.0:
		animationFramesSlowness= 1.0
	if isPickingAnim:
		return
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		distanceCurrentLimit += 1 if distanceCurrentLimit < 51 else 0
		removeTutorialUI_onCertainCondition()
		velocity = input_vector * ((maxSpeed - slow) + inventory.getSpeedPenalty()) * (delta * 100)
		if input_vector.x > 0:
			if !player_walk.playing:
				player_walk.play()
			play_animation(run_right[animation_use_id])
		elif input_vector.x < 0:
			if !player_walk.playing:
				player_walk.play()
			play_animation(run_left[animation_use_id])
		elif input_vector.y > 0:
			if !player_walk.playing:
				player_walk.play()
			play_animation(run_down[animation_use_id])
		elif input_vector.y < 0:
			if !player_walk.playing:
				player_walk.play()
			play_animation(run_up[animation_use_id])
	elif !isPickingAnim and input_vector == Vector2.ZERO:
		velocity = vZeros.move_toward(Vector2.ZERO, Friction * delta)
		play_animation(run_idle[animation_use_id]) # Play idle animation when not moving 
		player_walk.stop()


	if (Vector2.ZERO == input_vector && currentAnimation != "Idle_animation" or "_Helmet_Jerry_idle"):
		isPickingAnim = false
	#CHECK IF VECTOR IS 'NOT' NULL OR ZERO TO MOVE ON SPECIFIC CALCULATION, SET ZERO OTHERWISE LATTER
	if input_vector != Vector2.ZERO: 
		distanceCurrentLimit += 1 if distanceCurrentLimit < 51 else 0
		removeTutorialUI_onCertainCondition()
		velocity = input_vector * ($"..".AdditionalPlayerSpeed + bonusSpeed + (maxSpeed - slow) + inventory.getSpeedPenalty()) * (delta*100)
	else:
		velocity = vZeros.move_toward(Vector2.ZERO, Friction * delta) 
	#anim_player.speed_scale = animationFramesSlowness
	move_and_slide()

func _set_game_win_condition(action: Callable):
	game_win = action

func _set_game_over_action(action: Callable):
	game_over_action = action

func pickup():
	if currentAnimation != "Pickup_animation" or "_Helmet_Jerry_pickup":
		isPickingAnim = true
		isPicking = true
		player_pickup.play()
		play_animation(run_pickup[animation_use_id])

func update_label(text_content, isColor): #Set the child label node 
	var label = get_parent().get_node("player/AllUIParents/Globe_Timer_Sprite/Label_Timer")
	if !$AllUIParents/Globe_Timer_Sprite/Meteor_animated.is_playing():
		$AllUIParents/Globe_Timer_Sprite/Meteor_animated.play("idle_meteor")
	$AllUIParents/Globe_Timer_Sprite/Meteor_animated.rotate(0.03)
	$AllUIParents/Timer/Label_Timer.text = str(text_content)
	label.text = str(text_content)

func play_animation(anim_name):
	if currentAnimation != anim_name:
		currentAnimation = anim_name
		anim_player.stop()
		anim_player.play(anim_name)
	

func _on_player_4_animation_finished() -> void:
	if currentAnimation == "Pickup_animation" or "_Helmet_Jerry_pickup":
		isPickingAnim = false
		isPicking = false
		anim_player.play(run_pickup[animation_use_id])
	pass # Replace with function body.

func _on_pause_button_button_down() -> void:
	buttons.play()
	var pause = $AllUIParents/PauseMenu
	pause._pause()


func ReadyToRun() -> void:
	isPicking = false


func removeTutorialUI_onCertainCondition():
	pass

func gameStart():
	if $"..".activate_timeLimit:
		await get_tree().create_timer($"..".delayBeforeGameStart).timeout
		startUI()
	else: canMove = true
	$PlayerCamera.make_current()
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
	showUIUpon()
	$AllUIParents/StartUI_label.hide()
	canMove = true
	$_GameTimerLimit.GameStart()
	pass

func endScene():
	canMove = false
	hideallUI()
	if endAnimationOnce:
		$AllUIParents/BlackTransition.show()
		$AllUIParents/BlackTransition.play("default")
		$AllUIParents/BlackTransition.visible = true
		endAnimationOnce = false
	await get_tree().create_timer(5).timeout 
	$AllUIParents/BlackTransition.hide()

func showUIUpon():
	if $"..".useGlobeTimerUI:
		$AllUIParents/Globe_Timer_Sprite.show()
	else:
		$AllUIParents/Timer.show()
		pass

	if $"..".show_crewInventoryUI:
		$AllUIParents/Crew_Show.show()

	if $"..".show_inventoryUI:
		$AllUIParents/UI_On_Hand.show()
		$AllUIParents/ResourceUI_InRun.show()

	if $"..".show_tutorialTip:
		$AllUIParents/TutorialAssets.show()

func hideallUI():
	$AllUIParents/Red_UI_Indicator.hide()
	$AllUIParents/UI_On_Hand.hide()
	$AllUIParents/Globe_Timer_Sprite.hide()
	$AllUIParents/Timer.hide()
	$AllUIParents/Crew_Show.hide()
	$AllUIParents/ResourceUI_InRun.hide()
	$AllUIParents/Crew_Show.hide()
	var tutorial = NodeFinder.find_node_by_name(get_tree().current_scene,"TutorialAssets")
	if tutorial: tutorial.queue_free()

func _game_over():
	canMove = false
	if game_over_action:
		game_over_action.call()

func gameWin():
	canMove = false
	if game_win:
		game_win.call()

func retry():
	if $"..".canRestartOnGameOver:
		$AllUIParents/GameOver.show()
		hideallUI()
		canMove = false
		var tutorial = NodeFinder.find_node_by_name(get_tree().current_scene,"TutorialAssets")
		if tutorial: tutorial.queue_free()
		Engine.time_scale = 0.0

func speedFruit():
	bonusSpeed += 300
	await get_tree().create_timer(7.0).timeout
	bonusSpeed -= 300 
	pass

func _on_checking_for_on_hit_effect_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		slow = 50.0
	pass # Replace with function body.


func _on_checking_for_on_hit_effect_body_exited(body: Node2D) -> void:
	if body is RigidBody2D:
		slow = 0.0
	pass # Replace with function body.


func _on__retry_pressed() -> void:
	Engine.time_scale = 1.0
	IngameStoredProcessSetting.is_previous_restart = true
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on__quit_pressed() -> void:
	IngameStoredProcessSetting.Scenes = "mainmenu"
	get_tree().change_scene_to_file("res://Scenes/LoadingScene.tscn")
	pass # Replace with function body.
