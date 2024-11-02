extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match int(randf()*3):
		0: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Grass_1.png")
		1: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Grass_2.png")
		2: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Grass_3.png")
	
	await get_tree().create_timer(randf()).timeout
	$AnimationPlayer.play("GrassSwinging_1")
	pass # Replace with function body.
