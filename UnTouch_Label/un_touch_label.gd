extends Control
@onready var label = $Label
@onready var nine_patch_rect = $NinePatchRect


func _ready() -> void:
	label.autowrap_mode = false
	label.connect("text_changed", Callable(self, "_on_label_text_changed"))
	#updateText("i have a beautiful gift for you in december morning of christmas eve")

func _on_label_text_changed():
	update_nine_patch_rect_size()

func updateText(TEXT):
	var text = insert_line_breaks(TEXT, 15)
	$Label.text = text
	update_nine_patch_rect_size()

func getNinePatchRectSize():
	return $NinePatchRect.size

func insert_line_breaks(text: String, max_length: int) -> String:
	var words = text.split(" ")
	var current_line = ""
	var result = ""
	for word in words:
		if current_line == "":
			current_line = word
		else:
			if current_line.length() + word.length() + 1 > max_length:
				result += current_line + "\n"
				current_line = word
			else:
				current_line += " " + word
	if current_line.length() > 0:
		result += current_line
	return result


func update_nine_patch_rect_size():
	var label_size = $Label.get_minimum_size()
	var new_width = max(label_size.x + 300, 200)
	var new_height = max(label_size.y+ 50, 200)
	$NinePatchRect.size = Vector2(new_width, new_height)
