extends Sprite2D
@onready var ai : AnimatedSprite2D = $CraftingAnimation
@onready var crafting_tab: Node2D = $"../../CraftingTab"
@onready var item_ui: Control = NodeFinder.find_node_by_name(get_tree().current_scene, "Item_UI")
@onready var buttons: AudioStreamPlayer = $"../../Buttons"

var RecentAnimation : String = ""
var isMouseInside : bool = false

func _ready() -> void:
	RecentAnimation = "Sleeping"
	ai.play("Sleeping")

func _on_mouse_to_crafting_interaction_mouse_entered() -> void:
	ai.play("HoveringIn")
	RecentAnimation = "HoveringIn"
	isMouseInside = true

func _on_mouse_to_crafting_interaction_mouse_exited() -> void:
	if !ai.is_playing() or (ai.is_playing() and ai.animation == "HoverBlinking"):
		RecentAnimation = "HoveringOut"
		ai.play("HoveringOut")
	isMouseInside = false

func _on_crafting_animation_animation_finished() -> void:
	if RecentAnimation == "HoveringOut" and item_ui.ongoingCraft == true:
		ai.play("Crafting")
		RecentAnimation = "Crafting"
	elif RecentAnimation == "HoveringOut":
		ai.play("Sleeping")
		RecentAnimation = "Sleeping"
	elif isMouseInside == false and (RecentAnimation == "HoveringIn" or RecentAnimation == "HoverBlinking"):
		ai.play("HoveringOut")
		RecentAnimation = "HoveringOut"
	elif isMouseInside and (RecentAnimation == "HoveringOut" or "Sleeping") and (RecentAnimation != "HoveringIn"):
		ai.play("HoveringIn")
		RecentAnimation = "HoveringIn"
	elif isMouseInside and (RecentAnimation == "HoveringOut" or "Sleeping" or "Crafting") and (RecentAnimation != "HoveringIn"):
		ai.play("HoveringIn")
		RecentAnimation = "HoveringIn"

func _on_blink_timer_timeout() -> void:
	if (RecentAnimation == "HoverBlinking" or RecentAnimation == "HoveringIn") and isMouseInside:
		ai.play("HoverBlinking")

# Crafting Enter
func _on_mouse_to_crafting_interaction_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		buttons.play()
		crafting_tab.openScreen()

func nowcrafting() -> void:
	if item_ui.ongoingCraft == true:
		ai.play("Crafting")
		RecentAnimation = "Crafting"
	else:
		ai.play("Sleeping")
