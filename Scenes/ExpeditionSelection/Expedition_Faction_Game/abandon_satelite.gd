extends Node2D

#NODES
@onready var space_image = $Space
@onready var _player = $player

#VARIABLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_onStartInitialize()
	pass # Replace with function body.


func _onStartInitialize():
	_randomizeSatelite()
	
	
	pass


func _randomizeSatelite():
	_player.get_parent().remove_child(_player)
	
	var randomStart = int(randf() * 4.0) +1
	space_image.rotate(randf() * 1.0)
	match randomStart:
		1:
			space_image.position = $Satelite_1.position
			_player.position = $Satelite_1/player_position.position
			$Satelite_1.add_child(_player)
			
			pass
		2:
			space_image.position = $Satelite_2.position
			_player.position = $Satelite_2/player_position.position
			$Satelite_2.add_child(_player)
			pass
		3:
			space_image.position = $Satelite_3.position
			_player.position = $Satelite_3/player_position.position
			$Satelite_3.add_child(_player)
			pass
		4:
			space_image.position = $Satelite_4.position
			_player.position = $Satelite_4/player_position.position
			$Satelite_4.add_child(_player)
			pass
	_player.gameStart()
