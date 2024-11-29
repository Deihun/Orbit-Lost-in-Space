extends Node2D
var content = []
@export var Const_MAXSIZE_Sprite2D : Vector2 = Vector2(500,350)


func _on_button_back_button_up() -> void:
	queue_free()

func initialize_me():
	if content.size() < 1:
		$Panel/Label.text = "There's no content here yet..."
		return
	$Panel/Label.text = "Select a guide"
	
	for c in content: 
			var stylebox = load("res://Scenes/Tutorial/Guide_Button_flat.tres")
			var label_data = c["label"]
			var title_data = c["title"]
			var texture_data = c["texture"]
			var button = Button.new()
			button.text = str(title_data)
			var data = []
			data.append(label_data)
			data.append(title_data)
			data.append(texture_data)
			button.connect("button_up",Callable (self,"button_press").bind(data))
			button.add_theme_stylebox_override("normal",stylebox)
			button.add_theme_stylebox_override("hover",stylebox)
			button.custom_minimum_size = Vector2(400,100)
			$Panel/ScrollContainer/VBoxContainer.add_child(button)
			print(label_data)  # This will print the label's content

func button_press(data):
	$Panel/Label.position = Vector2(731,355)
	$Panel/Label.text = data[0]
	$Panel/Sprite2D.show()
	$Panel/Sprite2D.texture = load(data[2])
	limit_sprite_size($Panel/Sprite2D)

func limit_sprite_size(sprite: Sprite2D):
	var texture_size = sprite.texture.get_size()
	var scale_factor = min(Const_MAXSIZE_Sprite2D.x / texture_size.x, Const_MAXSIZE_Sprite2D.y / texture_size.y)
	sprite.scale = Vector2(scale_factor, scale_factor)
