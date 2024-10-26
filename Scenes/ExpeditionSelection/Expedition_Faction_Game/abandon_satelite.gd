extends Node2D

#NODES
@onready var space_image = $Space
@onready var _player = $Player

#VARIABLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_onStartInitialize()


func _onStartInitialize():
	_randomizeSatelite()


func _randomizeSatelite():
	var randomStart = int(randf() * 4.0) +1
	space_image.rotate(randf() * 1.0)
	match randomStart:
		1:
			space_image.position = $Satelite_1.position
			_player.position = $Satelite_1/player_position.position +  $Satelite_1.position
			$DropBox.position = Vector2(2686,1167)
			pass
		2:
			space_image.position = $Satelite_2.position
			_player.position = $Satelite_2/player_position.position+  $Satelite_2.position
			$DropBox.position = Vector2(12072,270)
			pass
		3:
			space_image.position = $Satelite_3.position
			_player.position = $Satelite_3/player_position.position+  $Satelite_3.position
			$DropBox.position = Vector2(3333,6667)
			pass
		4:
			space_image.position = $Satelite_4.position
			_player.position = $Satelite_4/player_position.position+  $Satelite_4.position
			$DropBox.position = Vector2(12109,6743)
			pass
	print(randomStart)
	_player.gameStart()
