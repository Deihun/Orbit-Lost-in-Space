extends Control
@onready var label = $Label
@onready var nine_patch_rect = $"."

func _ready() -> void:
	label.autowrap_mode = false # Disable autowrap if you're manually handling line breaks
	label.connect("text_changed", Callable(self, "_on_label_text_changed"))
	update_nine_patch_rect_size()

func _on_label_text_changed():
	update_nine_patch_rect_size()

func updateText(TEXT):
	var text = insert_line_breaks(TEXT, 15)
	label.text = text
	call_deferred("update_nine_patch_rect_size")  # Ensures size update after layout settles

func getNinePatchRectSize():
	return nine_patch_rect.size

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
	var label_size = label.get_minimum_size()
	var new_width = max(label_size.x + 300, 200)
	var new_height = max(label_size.y + 50, 200)
	nine_patch_rect.size = Vector2(new_width, new_height)
	minimum_size_changed()  # Updates the size of the parent container, if applicable
