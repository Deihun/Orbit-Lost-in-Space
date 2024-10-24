extends Node

@onready var getResources = $"/root/GlobalResources"
@onready var item_title = NodeFinder.find_node_by_name(get_tree().current_scene, "Item_Title")
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var control: Control = $Control

var craftingItems
var recentAnimation = ""

func openScreen() -> void:
	sprite_2d.visible = true
	sprite_2d.play("Open")
	recentAnimation = "Open"
	
func closeScreen() -> void:
	control.visible = false
	sprite_2d.play("Close")
	recentAnimation = "Close"
	
func _on_sprite_2d_animation_finished() -> void:
	if recentAnimation == "Open":
		control.visible = true
	else:
		sprite_2d.visible = false

func space_suit_pressed() -> void:
	craftingItems = "SpaceSuit"
	item_title.text = craftingItems

func crowbar_pressed() -> void:
	craftingItems = "Crowbar"
	item_title.text = craftingItems

func laser_gun_pressed() -> void:
	craftingItems = "LaserGun"
	item_title.text = craftingItems

func _on_dehy_space_food_pressed() -> void:
	craftingItems = "DehySpaceFood"
	item_title.text = craftingItems

func medkit_charge_pressed() -> void:
	craftingItems = "MedkitCharge"
	item_title.text = craftingItems

func fre_dri_space_food_pressed() -> void:
	craftingItems = "FreDriSpaceFood"
	item_title.text = craftingItems

func hazmat_suit_pressed() -> void:
	craftingItems = "HazmatSuit"
	item_title.text = craftingItems
