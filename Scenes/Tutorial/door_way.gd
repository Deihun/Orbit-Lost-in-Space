extends Node2D

enum _rotation_enum { HORIZONTAL = 1, VERTICAL = 2, SLANT1 = 3, SLANT2 = 4}

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
	match(wallRotation):
		1: #HORIZONTAL
			$Door.play("Opening_horizontal")
			$DoorStatic.process_mode = Node.PROCESS_MODE_DISABLED
			isOpen = true
			$DoorStatic/Vertical.process_mode = Node.PROCESS_MODE_DISABLED
			$DoorStatic/CollisionShape2D.process_mode = Node.PROCESS_MODE_INHERIT
		2: #VERTICAL
			$Door.play("Opening")
			$DoorStatic.process_mode = Node.PROCESS_MODE_DISABLED
			isOpen = true
			$DoorStatic/Vertical.process_mode = Node.PROCESS_MODE_INHERIT
			$DoorStatic/CollisionShape2D.process_mode = Node.PROCESS_MODE_DISABLED

func close_door():
	$DoorStatic.process_mode = Node.PROCESS_MODE_INHERIT
	match(wallRotation):
		1:
			$Door.play("Closing_Horizontal")
			$DoorStatic/Vertical.disabled = true
			$DoorStatic/CollisionShape2D.disabled = false
			pass
		2:
			$Door.play("Closing")
			$DoorStatic/Vertical.disabled = false
			$DoorStatic/CollisionShape2D.disabled = true

			isOpen = false
