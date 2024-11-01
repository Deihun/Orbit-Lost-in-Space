extends Sprite2D



func _ready() -> void:
	match int(randf()*7):
		0: texture = load("res://AmbiencePurposes/Steelicus Assets/Tiles/Tile1-3.png")
		1: texture = load("res://AmbiencePurposes/Steelicus Assets/Tiles/Tile_2.png")
		2: texture = load("res://AmbiencePurposes/Steelicus Assets/Tiles/Tile_3.png")
		3: texture = load("res://AmbiencePurposes/Steelicus Assets/Tiles/Tile_4.png")
		4: texture = load("res://AmbiencePurposes/Steelicus Assets/Tiles/Tile_5.png")
		5: texture = load("res://AmbiencePurposes/Steelicus Assets/Tiles/Tile_6.png")
		6: texture = load("res://AmbiencePurposes/Steelicus Assets/Tiles/Tile_7.png")
	pass # Replace with function body.
