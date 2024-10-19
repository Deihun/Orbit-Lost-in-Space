extends Control

const dialogueTesting = preload("res://DialogueSystem/Dialogue.dialogue")

@export var _dialogueManager : DialogueResource 
@export var _dialogue_start : String = "start"

func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(_dialogueManager, _dialogue_start)
	pass
