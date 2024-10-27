extends Control

@onready var item_button = load("res://Crafting_UI/item_button.tscn") as PackedScene
@onready var item_container: VBoxContainer = $Panel/Panel/ItemContainer

var Items = 0
var CraftItems = ["Medkit Charge", "test2", "test3","test4", "test5", "test6","test7", "test8", "test9","test10", "test11", "test12"]

func _ready() -> void:
	get_craftedItems()
	set_Items()

func get_craftedItems() -> void:
	pass

func set_Items() -> void:
	Items = CraftItems.size()
	for i in Items:
		var ItemButton = item_button.instantiate()
		ItemButton.setItems = CraftItems[i]
		item_container.add_child(ItemButton)

func _on_button_pressed() -> void:
	self.hide()
