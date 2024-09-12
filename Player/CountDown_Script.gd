extends Timer

#VARIABLE
const countdown_start = 90
var countdown_status = true
var isGameStart = false
var countdown_live


#VOID METHODS
func _ready(): #Set-up the timer to start 
	countdown_live = countdown_start + 1 

func GameStart():
	if !isGameStart:
		var tutorial_ui = NodeFinder.find_node_by_name(get_tree().current_scene, "TutorialAssets")
		tutorial_ui.fadeOut()
		start()
		isGameStart = true
	pass


func _on_timeout(): #Simple recursion everytime the timer stops, update the UI till it hits zero
	countdown_live -= 1
	var player_node = get_node("../player")
	if countdown_live > -1 && countdown_status:
		player_node.update_label(countdown_live, false)
		start()
	elif countdown_status: 
		checkForPlayer()


func checkForPlayer(): #Access dropbox hitboxes, if players inside, change scene; otherwise _______
	var isPlayerInside = NodeFinder.find_node_by_name(get_tree().current_scene, "Player_Final_Count")
	if isPlayerInside.getIsPlayerInsideCondition():
		get_tree().change_scene_to_file("res://Scenes/TestingInteriorScene.tscn")
	else:
		get_tree().reload_current_scene()
