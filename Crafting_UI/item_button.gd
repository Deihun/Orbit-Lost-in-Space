extends Control

@onready var button: Button = $Button
@onready var Items = CraftingItems

var setItems
var ItemName
var itemProperties

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.text = setItems
