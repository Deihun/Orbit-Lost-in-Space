extends Control
@onready var back_button = $Back
@onready var next_button = $Next
@onready var texture_sprite = $sprite_TutorialPanel
@onready var description_label = $Label_Description_Tutorial
@onready var Colorrect = $ColorRect

@export var tutorialDescription : Array[String] 
@export var textureLink : Array[String] 
@export var Const_MAXSIZE_Sprite2D : Vector2
@export var Closable: bool = true

var noShowAgain: bool = false
var TutorialModeOn: bool = true
var current_index: int = 0



func _ready():
	if !TutorialModeOn:
		queue_free()
	instantiate()
	update_content()

func instantiate():
	pass

func update_content():
	if current_index >= 0 and current_index < tutorialDescription.size():
		description_label.text = tutorialDescription[current_index]
		description_label.visible = true
	else:
		description_label.visible = false
	if current_index >= 0 and current_index < textureLink.size():
		var texture = load(textureLink[current_index])
		if texture:
			texture_sprite.texture = texture
			texture_sprite.visible = true
			limit_sprite_size(texture_sprite)
		else:
			texture_sprite.visible = false
	else:
		texture_sprite.visible = false
	if current_index == min(tutorialDescription.size(), textureLink.size()) - 1:
		next_button.text = "Close"
		next_button.visible = Closable
	else:
		next_button.text = "Next"
		next_button.visible = true
	if current_index != 0:
		back_button.visible = true
	else:
		back_button.visible = false


func limit_sprite_size(sprite: Sprite2D):
	var texture_size = sprite.texture.get_size()
	var scale_factor = min(Const_MAXSIZE_Sprite2D.x / texture_size.x, Const_MAXSIZE_Sprite2D.y / texture_size.y)
	sprite.scale = Vector2(scale_factor, scale_factor)


func _on_next_button_pressed():
	noShowAgain = $CheckBox.button_pressed
	if current_index < min(tutorialDescription.size(), textureLink.size()) - 1:
		current_index += 1
		update_content()
	elif current_index == min(tutorialDescription.size(), textureLink.size()) - 1:
		if noShowAgain:
			print("will call the settings")
			pass
		queue_free()

func _on_back_button_pressed():
	if current_index > 0:
		current_index -= 1
		update_content()
