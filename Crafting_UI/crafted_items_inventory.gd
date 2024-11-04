extends Control

@onready var item_button = load("res://Crafting_UI/item_button.tscn") as PackedScene
@onready var item_container: VBoxContainer = $Panel/Panel/ItemContainer
@onready var get_unique_item = GlobalResources
@onready var buttons: AudioStreamPlayer = $Buttons


var Items = 0
var CraftItems = []

func _ready() -> void:
	CraftItems = get_unique_item.eventID
	set_Items()

func set_Items() -> void:

	resetChild()
	CraftItems = GlobalResources.uniqueItems
	Items = CraftItems.size()
	for i in Items:
		var ItemButton = item_button.instantiate()
		ItemButton.setItems = CraftItems[i]
		item_container.add_child(ItemButton)

func _on_button_pressed() -> void:
	self.hide()

func resetChild() -> void:
	for child in item_container.get_children():
		child.queue_free() 
