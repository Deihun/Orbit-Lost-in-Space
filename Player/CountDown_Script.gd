extends Timer

#VARIABLE
const countdown_start = 60
var countdown_status = true
var countdown_live


#VOID METHODS
func _ready(): #Set-up the timer to start 
	countdown_live = countdown_start + 1 
	start()


func _on_timeout(): #Simple recursion everytime the timer stops, update the UI till it hits zero
	countdown_live -= 1
	var player_node = get_node("../player")
	if countdown_live > -1 && countdown_status:
		player_node.update_label(countdown_live, false)
		start()
	elif countdown_status: 
		checkForPlayer()


func checkForPlayer(): #Access dropbox hitboxes, if players inside, change scene; otherwise _______
	var isPlayerInside = get_node("/root/TestingOnRun/DropBox/Player_Final_Count")
	if isPlayerInside.getIsPlayerInsideCondition():
		get_tree().change_scene_to_file("res://Scenes/TestingInteriorScene.tscn")
	else:
		print("Nasa Labas")
		countdown_status = false