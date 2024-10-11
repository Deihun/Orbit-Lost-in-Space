extends Timer

#VARIABLE
@export var countdown_start : int= 3
var countdown_status : bool = true
var isGameStart : bool = false
var countdown_live : int
var dropBoxWarningStart : bool = false


#VOID METHODS
func _ready(): #Set-up the timer to start 
	countdown_live = countdown_start + 1 

func GameStart():
	if !isGameStart:
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
	if!dropBoxWarningStart and countdown_live < 11:
		var redUI = NodeFinder.find_node_by_name(get_tree().current_scene,"Red_UI_Indicator")
		var dropboxWarning = NodeFinder.find_node_by_name(get_tree().current_scene, "LastMinute_Dropbox_indicator")
		dropboxWarning.start()
		dropBoxWarningStart = true
		redUI.visible = true

func checkForPlayer(): #Access dropbox hitboxes, if players inside, change scene; otherwise _______
	var isPlayerInside = NodeFinder.find_node_by_name(get_tree().current_scene, "Player_Final_Count")
	var player = NodeFinder.find_node_by_name(get_tree().current_scene, "player")
	if isPlayerInside.getIsPlayerInsideCondition():
		var db = NodeFinder.find_node_by_name(get_tree().current_scene, "DropBox")
		db.interaction()
		var r = NodeFinder.find_node_by_name(get_tree().current_scene, "ResourceUI_InRun")
		r.updateGlobalResource()
		player.endScene()
	else:
		get_tree().reload_current_scene()
