   extends Node2D


onready var wallSprite = $Environment/Wall;
onready var floorNode = $Environment/Floors;
onready var furnitureHolder = $Furnitures;

onready var furnitureScene = load("res://scenes/Items/Furnitures.tscn")
onready var furnitureNodes = [];

onready var playerNode = $Entities/Player
onready var worldNode = get_tree().root.get_child(0)


func setRoom(roomKey, playerPos : Vector2, playerFlipped : bool):
	var roomData = load("res://Store/rooms/" + roomKey + ".tres")
	worldNode.currentRoomFloor = roomData.roomFloor
	wallSprite.texture = roomData.wallSprite;
	for floorChild in floorNode.get_children():
		floorChild.texture = roomData.floorSprite;
	setFurnitures(roomData)
	setPlayerSpawn(playerPos, playerFlipped)
	
	
func setFurnitures(roomData):
	for itemName in roomData.itemNames:
		var furnitureData = load("res://Store/items/" + itemName + ".tres")
		var furniture = furnitureScene.instance()
		furnitureHolder.add_child(furniture)
		furniture.global_position = furnitureData.spawnPosition;
		furniture.setSprite(furnitureData)
		furnitureNodes.append(furniture)
		
		
func setPlayerSpawn(playerPos, isPlayerFlipped):
	playerNode.global_position = playerPos
	playerNode.playerAnimatonSprite.flip_h = isPlayerFlipped
	
	
	
	
