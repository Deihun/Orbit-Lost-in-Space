extends Node2D

@onready var glassshard_1 = $GlassShard1
@onready var glassshard_2 = $GlassShard2
@onready var glassshard_3 = $GlassShard3
var speed = 1000.0

func _ready():
	$broken_glass.play()
	match int(randf() * 4):
		1:
			$Puddle.texture = load("res://Resources/SmallBiogene_Broken_Puddle_1.png")
		2:
			$Puddle.texture = load("res://Resources/SmallBiogene_Broken_Puddle_2.png")
		3:
			$Puddle.texture = load("res://Resources/SmallBiogene_Broken_Puddle_3.png")
	$Puddle.rotation = randf()*1
	var glass_shards = [glassshard_1, glassshard_2, glassshard_3]
	for shard in glass_shards:
		if shard:
			var random_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
			shard.rotation = randf() * 360
			shard.apply_central_force(random_direction)


func _process(delta):
	pass

	# Puddle remains stationary
	# No need to update its position
