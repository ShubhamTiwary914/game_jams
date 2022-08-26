   extends Node2D


onready var wallSprite = $Environment/Wall;
onready var floorNode = $Environment/Floors;
onready var furnitureHolder = $Furnitures;

onready var furnitureScene = load("res://scenes/Items/Furnitures.tscn")
onready var furnitureNodes = [];


onready var worldNode = get_tree().root.get_child(0)
onready var playerNode = $Entities/Player
onready var ghostScene = load("res://scenes/Entities/ghost.tscn")
onready var ghostSpawnPoints = [Vector2(100,100), Vector2(800, 100), Vector2(400, 100)]





#     ----- FURNITURES + ROOM  SPAWN ------------
func setRoom(roomKey, playerPos : Vector2, playerFlipped : bool):
	var roomData = load("res://Store/rooms/" + roomKey + ".tres")
	worldNode.currentRoom = roomKey
	worldNode.currentRoomFloor = roomData.roomFloor
	wallSprite.texture = roomData.wallSprite;
	for floorChild in floorNode.get_children():
		floorChild.texture = roomData.floorSprite;
	setFurnitures(roomData)
	setPlayerSpawn(playerPos, playerFlipped)
	
	
func setFurnitures(roomData):
	for itemName in roomData.itemNames:
		if(!worldNode.itemBlackList.has(itemName)):
			var furnitureData = load("res://Store/items/" + itemName + ".tres")
			var furniture = furnitureScene.instance()
			furnitureHolder.add_child(furniture)
			furniture.global_position = furnitureData.spawnPosition;
			furniture.setSprite(furnitureData)
			furnitureNodes.append(furniture)
		
	
func destroyFurniture(furnitureName : String):
	for furniture in furnitureNodes:
		if(furniture.furnitureData.furnitureName == furnitureName):
			worldNode.itemBlackList.append(furnitureName)
			furniture.queue_free()
	
	

#    ------------- ENTITIES SPAWN   ----------------
	
func setPlayerSpawn(playerPos, isPlayerFlipped):
	playerNode.global_position = playerPos
	playerNode.playerAnimatonSprite.flip_h = isPlayerFlipped
	

	
func _on_ghostSpawner_timeout():
	var spawnProbability = worldNode.randomNumberGenerator(0, 4)
	if(!worldNode.isDialogActive):
		if(spawnProbability == 0):
			if($Ghosts.get_child_count() < worldNode.maxGhostCount):
				var ghost = ghostScene.instance()
				ghost.global_position = ghostSpawnPoints[worldNode.randomNumberGenerator(0, len(ghostSpawnPoints))]
				$Ghosts.add_child(ghost)
	
	
	
	
	
