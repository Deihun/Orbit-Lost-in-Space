extends Node

@onready var getResources = $"/root/GlobalResources"
@onready var item_title = NodeFinder.find_node_by_name(get_tree().current_scene, "Item_Title")
@onready var item_description = NodeFinder.find_node_by_name(get_tree().current_scene, "Item_DescriptionLabel")
@onready var item_effect = NodeFinder.find_node_by_name(get_tree().current_scene, "Item_EffectLabel")
@onready var item_requirements = NodeFinder.find_node_by_name(get_tree().current_scene, "Item_RequirementsLabel")
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var control: Control = $Control
@onready var Items = CraftingItems

var craftingItems
var recentAnimation = ""

func _ready() -> void:
	space_suit_pressed()

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

#Crafting Items
func space_suit_pressed() -> void:
	craftingItems = "A.C.E.S"
	item_title.text = Items.ItemsName[0]
	item_description.text = Items.ItemDescription[0]
	item_effect.text = Items.ItemEffect[0]
	item_requirements.text = "Cost to craft: 300 Space-parts, 100 Oxygen, 10 Fuel, 1 Cycle"

func crowbar_pressed() -> void:
	craftingItems = "Crowbar"
	item_title.text = Items.ItemsName[1]
	item_description.text = Items.ItemDescription[1]
	item_effect.text = Items.ItemEffect[1]
	item_requirements.text = "Cost to craft: 350 Spare-parts, 10 Fuel, 1 Cycle"

func _on_dehy_space_food_pressed() -> void:
	craftingItems = "DehySpaceFood"
	item_title.text = Items.ItemsName[2]
	item_description.text = Items.ItemDescription[2]
	item_effect.text = Items.ItemEffect[2]
	item_requirements.text = "Cost to craft: 100 Biogene, 10 Fuel, 1 Cycle"

func medkit_charge_pressed() -> void:
	craftingItems = "MedkitCharge"
	item_title.text = Items.ItemsName[3]
	item_description.text = Items.ItemDescription[3]
	item_effect.text = Items.ItemEffect[3]
	item_requirements.text = "Cost to craft: 150 Biogene, 10 Fuel, 1 Cycle"

func fre_dri_space_food_pressed() -> void:
	craftingItems = "FreDriSpaceFood"
	item_title.text = Items.ItemsName[4]
	item_description.text = Items.ItemDescription[4]
	item_effect.text = Items.ItemEffect[4]
	item_requirements.text = "Cost to craft: 80 Biogene, 10 Fuel, 1 Cycle"

func hazmat_suit_pressed() -> void:
	craftingItems = "LeadSuitUp"
	item_title.text = Items.ItemsName[5]
	item_description.text = Items.ItemDescription[5]
	item_effect.text = Items.ItemEffect[5]
	item_requirements.text = "Cost to craft: 450 Spare-parts, 10 Fuel, 1 Cycle"
