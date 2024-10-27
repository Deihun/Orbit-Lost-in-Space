extends Sprite2D

func setHappy():
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Maxim/Maxim Lobby_Happy.png")

func setAngry(): 
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Maxim/Maxim Lobby_Angry.png")

func setNeutral(): 
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Maxim/Maxim Lobby_Neutral.png")

func isSick():
	$Sick.show()
