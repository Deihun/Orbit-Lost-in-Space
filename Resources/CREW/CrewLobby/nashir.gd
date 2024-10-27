extends Sprite2D


func setHappy():
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Nashir/Nashir Lobby_happy.png")

func setAngry(): 
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Nashir/Nashir Lobby_angry.png")

func setNeutral(): 
	$Reactions.texture = load("res://Resources/CREW/CrewLobby/Nashir/Nashir Lobby_neutral.png")

func isSick():
	$Sick.show()
