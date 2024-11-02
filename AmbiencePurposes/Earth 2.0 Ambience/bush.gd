extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match int(randf()*4):
		0: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Bush_1.png")
		1: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Bush_2.png")
		2: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Bush_3.png")
		3: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Bush_4.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
