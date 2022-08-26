extends Node2D

onready var worldNode = get_tree().root.get_child(0)



func startGame():
	var playerData = load("res://Store/playerData.tres")
	worldNode.playerSpawnPt = playerData.spawnPoint;
	worldNode.loadNewRoom(worldNode.spawnRoom, worldNode.playerSpawnPt, false)
	worldNode.itemSlots.visible = true


func loadGame_startMenu():
	var mainMenu = worldNode.menuScene.instance()
	worldNode.add_child(mainMenu)
	
	
	
	



