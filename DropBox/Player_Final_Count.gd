extends Area2D

#VARIABLES
var _isPlayerInside = false #Boolean for checking if player is touching the hitbox


#VOID METHODS
func _on_body_entered(body): #If player enters inside hitbox, change the condition into 'true'
	var layer_mask = body.collision_layer
	if layer_mask == 2:
		_isPlayerInside = true


func _on_body_exited(body): #If player exits from hitbox, change the condition into 'true'
	var layer_mask = body.collision_layer
	if layer_mask == 2:
		_isPlayerInside = false
		print("Area2D: Labas")


#RETURNING METHODS
func getIsPlayerInsideCondition(): #Allows the boolean to be access by others
	return _isPlayerInside
