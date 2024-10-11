extends Node2D

enum _rotation_enum { HORIZONTAL = 0, VERTICAL = 1, SLANT1 = 2, SLANT2 = 3}

@export var isOpen : bool = false
@export var wallRotation: _rotation_enum = _rotation_enum.HORIZONTAL

func _ready() -> void:
	if isOpen:
		open_door()
	else:
		close_door()
	
	match wallRotation:
		0:
			print("LEFT selected")
		1:
			print("RIGHT selected")
		2:
			print("UP selected")
		3:
			print("DOWN selected")

func open_door():
	$Door.play("Opening")
	$DoorStatic.process_mode = Node.PROCESS_MODE_DISABLED
	isOpen = true

func close_door():
	$Door.play("Closing")
	$DoorStatic.process_mode = Node.PROCESS_MODE_INHERIT
	isOpen = false
