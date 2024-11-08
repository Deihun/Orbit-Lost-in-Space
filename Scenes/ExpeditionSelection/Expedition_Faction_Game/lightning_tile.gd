extends AnimatedSprite2D

var recentAnimation : String = ""
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	await get_tree().create_timer(randf() * 3).timeout
	$Timer_Trigger_Lightning.start()

func _on_timer_trigger_lightning_timeout() -> void:
	$".".play("OnLightning")
	$TriggerLightning.play()
	recentAnimation= "OnLightning"
	$Area2D/CollisionShape2D.disabled = false
	$PointLight2D.show()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Im detecting something ", body.name)
	if body.name in ["Player","player"]:
		var player = NodeFinder.find_node_by_name(get_tree().current_scene,"Player")
		var playerCB = NodeFinder.find_node_by_name(get_tree().current_scene,"player")
		var a = preload("res://AmbiencePurposes/Steelicus Assets/Objects/getting_lightning.tscn").instantiate()
		player.playerGetDamage(5)
		player.add_child(a)
		a.position += playerCB.position + Vector2(0,-50)
		$GettingZap.play()


func _on_animation_finished() -> void:
	if recentAnimation == "OnLightning":
		$PointLight2D.hide()
		$Area2D/CollisionShape2D.disabled = true
		self.play("idle")
		recentAnimation = "idle"
	$Timer_Trigger_Lightning.start()
