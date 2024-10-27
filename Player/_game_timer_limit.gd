extends Timer


#VARIABLE
var countdown_start : int = 0
var countdown_status : bool = true
var isGameStart : bool = false
var countdown_live : int
var dropBoxWarningStart : bool = false


#VOID METHODS
func _ready(): #Set-up the timer to start 
	countdown_start = $"../..".limitTimeDuration
	countdown_live = countdown_start + 1 

func GameStart():
	if !isGameStart:
		self.start()
		isGameStart = true
	pass


func _on_timeout(): #Simple recursion everytime the timer stops, update the UI till it hits zero
	countdown_live -= 1
	var player_node = $".."
	if countdown_live > -1:
		player_node.update_label(countdown_live, false)
		start()
	else: 
		checkForPlayer()
	if!dropBoxWarningStart and countdown_live < 11:
		var redUI = NodeFinder.find_node_by_name(get_tree().current_scene,"Red_UI_Indicator")
		var dropboxWarning = NodeFinder.find_node_by_name(get_tree().current_scene, "LastMinute_Dropbox_indicator")
		
		if dropboxWarning:
			dropboxWarning.start()
			dropBoxWarningStart = true
		redUI.visible = true

func checkForPlayer(): #Access dropbox hitboxes, if players inside, change scene; otherwise _______
	var isPlayerInside = NodeFinder.find_node_by_name(get_tree().current_scene, "DropBox")
	if isPlayerInside:
		if isPlayerInside.getIsPlayerInsideCondition():
			isPlayerInside.interaction()
			var r = NodeFinder.find_node_by_name(get_tree().current_scene, "ResourceUI_InRun")
			r.updateGlobalResource()
			$"..".gameWin()
		else:
			$".."._game_over()
			#if $"../..".canRestartOnGameOver:
				#$"../AllUIParents/GameOver".show()
				#$"../AllUIParents/Pause_Button".hide()
				#$"..".hideallUI()
				#$"..".canMove = false
				#var tutorial = NodeFinder.find_node_by_name(get_tree().current_scene,"TutorialAssets")
				#if tutorial: tutorial.queue_free()
				#Engine.time_scale = 0.0
			#get_tree().reload_current_scene()
