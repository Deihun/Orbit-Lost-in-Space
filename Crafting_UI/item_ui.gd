extends Control

@onready var getResources = $"/root/GlobalResources"
@onready var crafting_tab = $"../.."
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
var currentlycrafting: String = "test"

func _on_craft_button_pressed() -> void:
	buttons.play()
	if (ongoingCraft == false):
		match crafting_tab.craftingItems:
			"A.C.E.S":
				if getResources.spareparts >= 300 && getResources.oxygen >= 100 && getResources.fuel >= 10:
					getResources.spareparts -= 300
					getResources.oxygen -= 100
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					setanimation.nowcrafting()
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"LeadSuitUp":
				if getResources.spareparts >= 400 && getResources.fuel >= 10:
					getResources.spareparts -= 400
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					setanimation.nowcrafting()
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"Crowbar":
				if getResources.spareparts >= 350 && getResources.fuel >= 10:
					getResources.spareparts -= 350
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true	
					setanimation.nowcrafting()
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			
			"MedkitCharge":
				if getResources.biogene >= 150 && getResources.fuel >= 10:
					getResources.biogene -= 150
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					setanimation.nowcrafting()
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"DehySpaceFood":
				if getResources.biogene >= 100 && getResources.fuel >= 10:
					getResources.biogene -= 150
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					setanimation.nowcrafting()
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
			
			"FreDriSpaceFood":
				if getResources.ration >= 20 && getResources.fuel >= 10:
					getResources.ration -= 20
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					setanimation.nowcrafting()
					NowCraftingShow()
					crafting_tab.closeScreen()
				else:
					warning_insufficientShow()
	else:
		ISCraftingShow()

func _on_cancel_button_pressed() -> void:
	buttons.play()
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
