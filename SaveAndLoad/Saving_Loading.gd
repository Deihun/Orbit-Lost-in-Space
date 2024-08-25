extends Node

const SAVE_PATH = "user://save_json.json"

func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	var player = get_data(player_data)
	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict = {
		player = {
			inventory = var_to_str(player.inventory)
		}
	}

	file.store_line(JSON.stringify(save_dict))

	get_node(^"../LoadJSON").disabled = false

func load_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary

	var player := get_data(player_data) as Player
	# JSON doesn't support many of Godot's types such as Vector2.
	# str_to_var can be used to convert a String to the corresponding Variant.
	player.inventory = str_to_var(save_dict.player.inventory)

	# Ensure the node structure is the same when loading.
	var game := get_data(game_data)
