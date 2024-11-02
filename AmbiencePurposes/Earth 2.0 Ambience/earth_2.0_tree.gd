extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match int(randf()*3):
		0: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Tree_1.png")
		1: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Tree_2.png")
		2: texture = load("res://AmbiencePurposes/Earth 2.0 Ambience/Tree_3.png")


func _on_area_2d_body_entered(body: Node2D) -> void:
	self.modulate.a = 0.5



func _on_area_2d_body_exited(body: Node2D) -> void:
	self.modulate.a = 1.0
