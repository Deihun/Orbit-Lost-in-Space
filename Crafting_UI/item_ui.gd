extends Control

@onready var crafting_tab: Node2D = get_parent().get_parent()
@onready var item_description_label: RichTextLabel = $Panel/Item_Description/Item_DescriptionLabel
@onready var item_effect_label: RichTextLabel = $Panel/Item_Effect/Item_EffectLabel
@onready var item_requirements_label: RichTextLabel = $Panel/Item_Requirements/Item_RequirementsLabel
@onready var item_title: Label = $Panel/Item_Name/Item_Title
@onready var warning: Panel = $Panel/Warning
@onready var warning_insufficient: Panel = $Panel/WarningInsufficient
@onready var now_crafting: Panel = $Panel/NowCrafting
@onready var item_picture: Sprite2D = $Panel/Item_Picture/ItemPicture
@onready var setanimation = NodeFinder.find_node_by_name(get_tree().current_scene, "Craft")
@onready var buttons: AudioStreamPlayer = $Buttons

var ongoingCraft = false
var currentlycrafting

func _on_craft_button_pressed() -> void:
	if (ongoingCraft == false):
		match crafting_tab.craftingItems:
			"A.C.E.S":
				if GlobalResources.spareparts >= 300 && GlobalResources.oxygen >= 100 && GlobalResources.fuel >= 10:
					GlobalResources.spareparts -= 300
					GlobalResources.oxygen -= 100
					GlobalResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					print(currentlycrafting)
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"LeadSuitUp":
				if GlobalResources.spareparts >= 400 && GlobalResources.fuel >= 10:
					GlobalResources.spareparts -= 400
					GlobalResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"Crowbar":
				if GlobalResources.spareparts >= 100 && GlobalResources.fuel >= 10:
					GlobalResources.spareparts -= 100
					GlobalResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true	
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"MedkitCharge":
				if GlobalResources.biogene >= 150 && GlobalResources.fuel >= 10:
					GlobalResources.biogene -= 150
					GlobalResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"DehySpaceFood":
				if GlobalResources.biogene >= 100 && GlobalResources.fuel >= 10:
					GlobalResources.biogene -= 150
					GlobalResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"FreDriSpaceFood":
				if GlobalResources.ration >= 20 && GlobalResources.fuel >= 10:
					GlobalResources.ration -= 20
					GlobalResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
	else:
		ISCraftingShow()

func _on_cancel_button_pressed() -> void:
	crafting_tab.closeScreen()

func warning_insufficientShow():
	warning_insufficient.show()
	var warningtimer: Timer = $Panel/WarningInsufficient/warningtimer
	warningtimer.start()
	
func NowCraftingShow():
	now_crafting.show()
	var now_craftingtimer: Timer = $Panel/NowCrafting/NowCraftingtimer
	now_craftingtimer.start()
	
func ISCraftingShow():
	warning.show()
	var crafting_timer: Timer = $Panel/Warning/CraftingTimer
	crafting_timer.start()

func _on_warningtimer_timeout() -> void:
	warning_insufficient.hide()

func _on_now_craftingtimer_timeout() -> void:
	now_crafting.hide()
	
func _on_crafting_timer_timeout() -> void:
	warning.hide()
