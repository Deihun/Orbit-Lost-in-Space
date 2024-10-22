extends Node2D

var gas = 0
var ration = 0 
var fuel = 0
var spareparts = 0
var biogene = 0
var ductape = 0
var crew_availability = 3

var crew ={ 
	"fumiko" = false,
	"maxim" = false,
	"nashir" = false,
	"regina" = false
}

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
		"Regina":
			print("regina is added for some reason")
			if crew["regina"] == false:	crew_availability -= 1
			crew["regina"] = true
			
		"Maxim" : 
			if crew["maxim"] == false:	crew_availability -= 1
			crew["maxim"] = true
		"Nashir" : 
			if crew["nashir"] == false:	crew_availability -= 1
			crew["nashir"] = true
		"Fumiko" :
			if crew["fumiko"] == false:	crew_availability -= 1
			crew["fumiko"] = true

func updateGlobalResource():
	var r = GlobalResources
	var b = IngameStoredProcessSetting
	r.ration = ration
	r.fuel = fuel
	r.oxygen = gas
	r.spareparts = spareparts
	r.biogene = biogene
	r.ductape = ductape
	r.emergencyOxy = 100
	r.emergencyFuel = 100
	
	if crew["regina"] == true and !b.crew_in_ship.has("Regina"): b.crew_in_ship.append("Regina")
	if crew["maxim"] == true and !b.crew_in_ship.has("Maxim"): b.crew_in_ship.append("Maxim")
	if crew["fumiko"] == true and !b.crew_in_ship.has("Fumiko"): b.crew_in_ship.append("Fumiko")
	if crew["nashir"] == true and !b.crew_in_ship.has("Nashir"): b.crew_in_ship.append("Nashir")
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
