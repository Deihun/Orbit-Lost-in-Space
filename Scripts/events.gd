extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.2).timeout
	_checkIfItHasEvent()



func _checkIfItHasEvent():
	if $Panel/CommandContainer/VBoxContainer.get_child_count() < 1:
		$Panel/HasNoCommandPanel.show()
		$Panel/Command_Guide.text = "No Existing Command"

func addTitleAndDescription(title: String, Description: String, id):
	$Panel/id.text = str("ID: ", id)
	$Panel/Title.text = title
	$Panel/Description.text = Description

func addConditionView(condition : String):
	$Panel/Condition_Guide.text = "Condition: " + condition
	$Panel/HasNoConditions.hide()


func addPreviewCommand(command : String):
	var _label = Label.new()
	$Panel/CommandContainer/VBoxContainer.add_child(_label)
	_label.text = command

func addChoiceButton(choice):
	$Panel/HasNoChoiceButton_Panel.hide()
	var a = preload("res://Scripts/choice_button_preview_panel.tscn").instantiate()
	a.id(choice[0])
	for requirements in choice[1]:
		a.add_requirement(requirements)
	a.description(choice[2])
	$Choice_ContainerView/VBoxContainer.add_child(a)

func isRandom_IsActive(random : bool, active : bool):
	$Panel/CanBeActive_Green/CanBeActive_RED.visible = !active
	$Panel/CanBeRandom_Green/CanBeActive_RED.visible = !random

func hiddenChoice(hiddenChoice):
	var label = Label.new()
	$canHiddenChoice.hide()
	label.text = str(hiddenChoice)
	$ScrollContainer/VBoxContainer.add_child(label)

func probability(_probability):
	$Panel/HasNoProbability.hide()
	var a = preload("res://Scripts/probability_viewer.tscn").instantiate()
	a.set_probability(_probability[0][0])
	for command in _probability[0][1]:
		a.add_view_command(str(command))
	$ProbabilityList/VBoxContainer.add_child(a)
