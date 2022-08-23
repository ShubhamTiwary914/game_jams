   extends Node2D


onready var wallSprite = $Environment/Wall;
onready var floorNode = $Environment/Floors;
onready var furnitureHolder = $Furnitures;

onready var furnitureScene = load("res://scenes/Items/Furnitures.tscn")
onready var furnitureNodes = [];



func setRoom(roomKey):
	var roomData = load("res://Store/rooms/" + roomKey + ".tres")
	wallSprite.texture = roomData.wallSprite;
	for floorChild in floorNode.get_children():
		floorChild.texture = roomData.floorSprite;
	setFurnitures(roomData)
	
	
func setFurnitures(roomData):
	for itemName in roomData.itemNames:
		var furnitureData = load("res://Store/items/" + itemName + ".tres")
		var furniture = furnitureScene.instance()
		furnitureHolder.add_child(furniture)
		furniture.global_position = furnitureData.spawnPosition;
		furniture.setSprite(furnitureData)
		furnitureNodes.append(furniture)
		
		

	
	
	
	
