extends Node2D

onready var generalRoomScene = load("res://scenes/Rooms/GeneralRoom.tscn")
onready var itemSlots = $itemSlots;




func _ready():
	var room = generalRoomScene.instance();
	$spawnLayer.add_child(room)
	room.setRoom("attic")
	


