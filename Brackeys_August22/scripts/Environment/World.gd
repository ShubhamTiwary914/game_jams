extends Node2D

onready var generalRoomScene = load("res://scenes/Rooms/GeneralRoom.tscn")
onready var itemSlots = $itemSlots;


onready var actionBtns = $actionBtns;
onready var useBtn = load("res://scenes/Interactables/UseButton.tscn")

onready var mouseCurrentTarget = "";
onready var dialogBoard = $dialogBoard;
onready var isDialogActive = false;


func _ready():
	var room = generalRoomScene.instance();
	$spawnLayer.add_child(room)
	room.setRoom("attic")


func randomNumberGenerator(start, end) -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = int(rng.randf_range(start, end))
	return my_random_number


 #   ------    INTERACTABLES  MANAGING  SECTION   ------
func createInteractive_button(furnitureData):
	var newFurnitureBtn = useBtn.instance();
	newFurnitureBtn.furnitureData = furnitureData;
	actionBtns.add_child(newFurnitureBtn)
	
func destroyInteractive_button(furnitureName):
	for actionBtn in actionBtns.get_children():
		if(actionBtn.furnitureData.furnitureName == furnitureName):
			actionBtn.queue_free()


func interactiveMouse_clicked():
	for actionBtn in actionBtns.get_children():
		if(actionBtn.furnitureData.furnitureName == mouseCurrentTarget):
			actionBtn._on_mouseClicked();

func skipDialog():
	if(isDialogActive):
		dialogBoard.get_child(0).queue_free()
		isDialogActive = false;
	
				

	
