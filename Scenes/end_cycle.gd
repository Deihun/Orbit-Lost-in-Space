extends Area2D
@onready var picture : Sprite2D = $Sprite2D

var isActive : bool = true
var active = preload("res://Scenes/UI/EndCycle_Enable.png")
var inactive = preload("res://Scenes/UI/EndCycle_Disable.png")
var hover = preload("res://Scenes/UI/EndCycle_Hover.png")
@onready var buttons: AudioStreamPlayer = $"../../../Buttons"

func _on_mouse_exited() -> void:
	if isActive: picture.texture = active
	else: picture.texture = inactive
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	if isActive : picture.texture = hover

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		buttons.play()
		$"../../.."._on_next_day_button_pressed()
	pass # Replace with function body.

func disable():
	isActive = false
	picture.texture = inactive

func enable():
	isActive = true
	picture.texture = active
