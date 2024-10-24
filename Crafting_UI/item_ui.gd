extends Control

@onready var getResources = $"/root/GlobalResources"
@onready var crafting_tab: Node2D = get_parent().get_parent()
@onready var item_description_label: RichTextLabel = $Panel/Item_Description/Item_DescriptionLabel
@onready var item_effect_label: RichTextLabel = $Panel/Item_Effect/Item_EffectLabel
@onready var item_requirements_label: RichTextLabel = $Panel/Item_Requirements/Item_RequirementsLabel
@onready var item_title: Label = $Panel/Item_Name/Item_Title

var ongoingCraft = false
var currentlycrafting

func _on_craft_button_pressed() -> void:
	if (ongoingCraft == false):
		match crafting_tab.craftingItems:
			"SpaceSuit":
				if getResources.spareparts >= 300 && getResources.oxygen >= 100 && getResources.fuel >= 10:
					getResources.spareparts -= 300
					getResources.oxygen -= 100
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
				else:
					print("Insufficient Items!")
			
			"HazmatSuit":
				if getResources.spareparts >= 400 && getResources.fuel >= 10:
					getResources.spareparts -= 400
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					print("Successfully Made!")
				else:
					print("Insufficient Items!")
			
			"Crowbar":
				if getResources.spareparts >= 350 && getResources.fuel >= 10:
					getResources.spareparts -= 350
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true	
					print("Successfully Made!")
				else:
					print("Insufficient Items!")
			
			"LaserGun":
				if getResources.spareparts >= 350 && getResources.biogene >= 20 && getResources.fuel >= 10:
					getResources.spareparts -= 350
					getResources.biogene -= 20
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					print("Successfully Made!")
				else:
					print("Insufficient Items!")
			
			"MedkitCharge":
				if getResources.biogene >= 150 && getResources.fuel >= 10:
					getResources.biogene -= 150
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					print("Successfully Made!")
				else:
					print("Insufficient Items!")
			
			"DehySpaceFood":
				if getResources.biogene >= 100 && getResources.fuel >= 10:
					getResources.biogene -= 150
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					print("Successfully Made!")
				else:
					print("Insufficient Items!")
			
			"FreDriSpaceFood":
				if getResources.ration >= 20 && getResources.fuel >= 10:
					getResources.ration -= 20
					getResources.fuel -= 10
					currentlycrafting = crafting_tab.craftingItems
					ongoingCraft = true
					print("Successfully Made!")
				else:
					print("Insufficient Items!")
				print("Select a Item")
	else:
		print("Currently Crafting a Item")

func _on_cancel_button_pressed() -> void:
	crafting_tab.closeScreen()
