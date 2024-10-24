extends Node2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $NinePatchRect/Label
@onready var backSupport = $NinePatchRect

const base_text = "[E] "

var active_area = []
var can_interact = true

func register_area(area: InteractionArea):
	active_area.push_back(area)

func unregister_area(area: InteractionArea):
	var index =  active_area.find(area)
	if index != -1:
		active_area.remove_at(index)

		
func _input(event):
	if event.is_action_pressed("Interact") && can_interact:
		if active_area.size() > 0:
			can_interact = false
			label.hide()
			var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")
			var tutorial_ui = NodeFinder.find_node_by_name(get_tree().current_scene, "TutorialAssets")
			if tutorial_ui:
				tutorial_ui.fadeOut()
			await active_area[0].interact.call()
			can_interact = true

func _process(delta):
	if active_area.size() > 0 && can_interact:
		if _sort_by_distance_to_player:
			active_area.sort_custom(_sort_by_distance_to_player)
			label.text = base_text + active_area[0].action_name.to_upper()
			backSupport.global_position = active_area[0].global_position
			backSupport.global_position.y -= 150
			backSupport.global_position.x -= (label.size.x / 2) + 50
			var label_size = label.get_minimum_size()
			var new_width = max(label_size.x + 50, 50)
			var new_height = max(label_size.y+ 75, 75)
			backSupport.size = Vector2(new_width, new_height)
			backSupport.show()
			
			label.show()
		else:
			label.hide()
			backSupport.hide()
	else:
		label.hide()
		backSupport.hide()

func _sort_by_distance_to_player(area1, area2):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		if player == null:
			return false
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
