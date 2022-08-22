extends Node2D

onready var generalRoomScene = load("res://scenes/Rooms/GeneralRoom.tscn")



func _ready():
	var room = generalRoomScene.instance();
	add_child(room)
	room.setRoom("hallway")
	

