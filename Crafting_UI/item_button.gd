extends Control

@onready var button: Button = $Button
@onready var Items = CraftingItems
@onready var item_desc_label = NodeFinder.find_node_by_name(get_tree().current_scene, "ItemDescLabel")
@onready var item_effect_label = NodeFinder.find_node_by_name(get_tree().current_scene, "ItemEffectLabel")

var setItems
var ItemName
var checkItem = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	matchItem()
	button.text = Items.ItemsName[checkItem]
	
func setDescription():
	item_desc_label.text = Items.ItemDescription[checkItem]
	item_effect_label.text = Items.ItemEffect[checkItem]

func matchItem() -> void:
	match setItems:
		"A.C.E.S":
			checkItem = 0
		"Crowbar":
			checkItem = 1
		"DehySpaceFood":
			checkItem = 2
		"MedkitCharge":
			checkItem = 3
		"FreDriSpaceFood":
			checkItem = 4
		"LeadSuitUp":
			checkItem = 5

func _on_button_pressed() -> void:
	setDescription()
