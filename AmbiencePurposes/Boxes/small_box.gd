extends StaticBody2D

var up : bool = false
var down : bool = false
var left : bool = false
var right : bool = false




func _on_push_up_body_entered(body: Node2D) -> void:
	if !(body is CharacterBody2D or (StaticBody2D)):
		return
	up = true
	while up:
		await get_tree().create_timer(0.05).timeout
		position += Vector2(0,-1.5)



func _on_push_up_body_exited(body: Node2D) -> void:
	up = false



func _on_push_down_body_entered(body: Node2D) -> void:
	if !(body is CharacterBody2D or (StaticBody2D)):
		return
	down = true
	while down:
		await get_tree().create_timer(0.05).timeout
		position += Vector2(0,1.5)


func _on_push_down_body_exited(body: Node2D) -> void:
	down = false


func _on_push_left_body_entered(body: Node2D) -> void:
	if !(body is CharacterBody2D or (StaticBody2D)):
		return
	left = true
	while left:
		await get_tree().create_timer(0.05).timeout
		position += Vector2(-1.5,0)


func _on_push_left_body_exited(body: Node2D) -> void:
	left = false


func _on_push_right_body_entered(body: Node2D) -> void:
	if !(body is CharacterBody2D or (StaticBody2D)):
		return
	right = true
	while right:
		await get_tree().create_timer(0.05).timeout
		position += Vector2(1.5,0)


func _on_push_right_body_exited(body: Node2D) -> void:
	right = false
