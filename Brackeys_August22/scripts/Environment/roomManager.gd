extends Node2D


onready var wallSprite = $Environment/Wall;
onready var floorNode = $Environment/Floors;


func setRoom(roomKey):
	var roomData = load("res://Store/rooms/" + roomKey + ".tres")
	wallSprite.texture = roomData.wallSprite;
	for floorChild in floorNode.get_children():
		floorChild.texture = roomData.floorSprite;
	
	
	
	
