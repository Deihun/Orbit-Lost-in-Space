extends Sprite2D


func setHappy():
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/FumikoReaction/Fumiko Lobby_Happy.png")

func setAngry(): 
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/FumikoReaction/Fumiko Lobby_Angry.png")

func setNeutral(): 
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/FumikoReaction/Fumiko Lobby_Neutral.png")

func isSick():
	$Sick.show()

func set_Basis():
	var crewName = "Fumiko"
	$Sick.hide()
	if IngameStoredProcessSetting._disease[crewName] >= 0.65 or IngameStoredProcessSetting._health[crewName] <= 0.25:
		$Sick.show()
	if IngameStoredProcessSetting._relationship[crewName] > 0.8:
		if IngameStoredProcessSetting._sanity > 0.4 and IngameStoredProcessSetting._current_hunger[crewName] > 0.5:setHappy()
		else: setNeutral()
	elif IngameStoredProcessSetting._relationship[crewName] >= 0.49 and IngameStoredProcessSetting._relationship[crewName] <= 0.79:
		setNeutral()
	elif IngameStoredProcessSetting._relationship[crewName] <= 0.15:
		setAngry()
