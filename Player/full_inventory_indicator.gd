extends Node2D
@onready var exp = $Expiration
@onready var ani =$Animation

var repeatCount = 0

func _ready() -> void:
	visible = false
	pass

func onStart(message : String = "Inventory Full!"):
	visible = true
	$Label.visible = true
	$Label2.visible = false
	$Label.text = message
	$Label2.text = message
	repeatCount = 0
	ani.stop()
	exp.stop()
	ani.start()
	exp.start()

func _on_expiration_timeout() -> void:
	$Label.visible = !$Label.visible
	$Label2.visible = !$Label2.visible
	repeatCount += 1
	if repeatCount < 4:
		exp.start()
	pass # Replace with function body.


func _on_animation_timeout() -> void:
	visible = false
	pass # Replace with function body.
