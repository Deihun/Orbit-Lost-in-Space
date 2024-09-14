extends Node2D

var gas = 0
var ration = 0 
var fuel = 0
var spareparts = 0
var biogene = 0
var ductape = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func add_item(item_type):#Use to direct add items, used by other objects such as dropbox to add items
	match(item_type):
		"Small Food":
			ration += 10
			$Label_Food.text = str("Ration: " , ration)
		"Small Fuel":
			fuel += 13
			$Label_Fuel.text = str("Fuel: " , fuel)
		"Small Spareparts":
			spareparts += 15
			$Label_Spareparts.text =str("Spareparts: " ,  spareparts)
			
		"Small Biogene":
			biogene += 15
			$Label_Biogene.text =str("Biogene: " ,  biogene)
			
		"Ductape":
			ductape += 1
			$Label_Ductape.text = str("Ductape: " , ductape)
		"Small Gastank":
			gas += 15
			$Label_Oxygen.text = str("Oxygen: ", gas)

func updateGlobalResource():
	var r = GlobalResources
	r.ration = ration
	r.fuel = fuel
	r.oxygen = gas
	r.spareparts = spareparts
	r.biogene = biogene
	r.ductape = ductape
	r.emergencyOxy = 100
	r.emergencyFuel = 100
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
