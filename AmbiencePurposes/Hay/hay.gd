extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match int(randf() * 4):
		1: texture = load("res://AmbiencePurposes/Hay/Hay1.png")
		2: texture = load("res://AmbiencePurposes/Hay/Hay2.png")
		3: texture = load("res://AmbiencePurposes/Hay/Hay3.png")
	
	if 0.5 > randf(): flip_h = true
	await get_tree().create_timer(randf()).timeout
	$AnimationPlayer.play("HayMovement")
