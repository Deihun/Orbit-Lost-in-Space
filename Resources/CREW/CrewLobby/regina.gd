extends Sprite2D

func setHappy():
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Regina/Regina Lobby_Happy.png")

func setAngry(): 
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Regina/Regina Lobby_Angry.png")

func setNeutral(): 
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Regina/Regina Lobby_neutral.png")

func isSick():
	$Sick.show()
