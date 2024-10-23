extends Node

@onready var getResources = $"/root/GlobalResources"
@onready var item_title = NodeFinder.find_node_by_name(get_tree().current_scene, "Item_Title")

var craftingItems

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
