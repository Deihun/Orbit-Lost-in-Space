extends Control

@onready var button: Button = $Button
@onready var Items = CraftingItems
@onready var item_desc_label = NodeFinder.find_node_by_name(get_tree().current_scene, "ItemDescLabel")
@onready var item_effect_label = NodeFinder.find_node_by_name(get_tree().current_scene, "ItemEffectLabel")
@onready var item_pic = NodeFinder.find_node_by_name(get_tree().current_scene, "ItemPic")

var setItems
var ItemName
var checkItem = 0
var ItemPath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	matchItem()
	button.text = Items.ItemsName[checkItem]
	
func setDescription():
	item_desc_label.text = Items.ItemDescription[checkItem]
	item_effect_label.text = Items.ItemEffect[checkItem]
	item_pic.texture = load(ItemPath)

func matchItem() -> void:
	match setItems:
		"A.C.E.S":
			checkItem = 0
			ItemPath = "res://Crafting_UI/ItemAssests/ACES_SUIT.png"
		"Crowbar":
			checkItem = 1
			ItemPath = "res://Crafting_UI/ItemAssests/CrowBar.png"
		"DehySpaceFood":
			checkItem = 2
			ItemPath = "res://Crafting_UI/ItemAssests/DriedSpaceFood.png"
		"MedkitCharge":
			checkItem = 3
			ItemPath = "res://Crafting_UI/ItemAssests/Medicine_Pickup.png"
		"FreDriSpaceFood":
			checkItem = 4
			ItemPath = "res://Crafting_UI/ItemAssests/DeepDriedSpaceFood.png"
		"LeadSuitUp":
			checkItem = 5
			ItemPath = "res://Crafting_UI/ItemAssests/ACES_SUIT.png"

func _on_button_pressed() -> void:
	setDescription()
