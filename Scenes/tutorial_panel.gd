extends Control
@onready var back_button = $Back
@onready var next_button = $Next
@onready var texture_sprite = $sprite_TutorialPanel
@onready var description_label = $Label_Description_Tutorial
@onready var Title = $Label_Title
@onready var Colorrect = $ColorRect

@export var tutorialTitle : Array[String]
@export var tutorialDescription : Array[String] 
@export var textureLink : Array[String] 
@export var Const_MAXSIZE_Sprite2D : Vector2
@export var Closable: bool = true
@export var tutorialPanel_ID : int 


var noShowAgain: bool = false
var TutorialModeOn: bool = getTutorialData()
var current_index: int = 0
var parentsScript

func _ready():
	TutorialModeOn = getTutorialData()
	parentsScript = NodeFinder.find_node_by_name(get_tree().current_scene, "TutorialPanel_Folder")
	
	if !TutorialModeOn or TutorialModeOn == null:
		queue_free()
	instantiate()
	update_content()
	if !Closable:
		$CheckBox.process_mode = Node.PROCESS_MODE_DISABLED
		$CheckBox.hide()
		$ColorRect.queue_free()

func instantiate():
	pass

func getTutorialData():
	print("ID : ",tutorialPanel_ID)
	match(tutorialPanel_ID ):
		1:
			return SettingsDataContainer.tutorialPanel_1
		2:
			return SettingsDataContainer.tutorialPanel_2
		3:
			return SettingsDataContainer.tutorialPanel_3
		4:
			return SettingsDataContainer.tutorialPanel_4
		null:
			return false
		_:
			return true

func update_content():
	if current_index >= 0 and current_index < tutorialDescription.size():
		description_label.text = tutorialDescription[current_index]
		description_label.visible = true
		Title.text = tutorialTitle[current_index]
		Title.visible = true
	else:
		description_label.visible = false
		Title.visible = false
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
		if parentsScript:
			parentsScript.addData(tutorialPanel_ID ,$CheckBox.is_pressed())
			process_mode = Node.PROCESS_MODE_ALWAYS
		queue_free()

func _on_back_button_pressed():
	if current_index > 0:
		current_index -= 1
		update_content()
