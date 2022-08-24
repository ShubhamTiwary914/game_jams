extends Node2D

onready var generalRoomScene = load("res://scenes/Rooms/GeneralRoom.tscn")
onready var itemSlots = $itemSlots;


onready var actionBtns = $actionBtns;
onready var useBtn = load("res://scenes/Interactables/UseButton.tscn")
onready var roomDialog_scene = load("res://scenes/Interactables/roomDialog.tscn")


onready var mouseCurrentTarget = "";
onready var dialogBoard = $dialogBoard;
onready var isDialogActive = false;


onready var playerSpawnPt;
onready var playerFlippedX = false;
onready var roomHasLoaded = false;
onready var currentRoomFloor : String;


func _ready():
	var playerData = load("res://Store/playerData.tres")
	playerSpawnPt = playerData.spawnPoint;
	loadNewRoom("attic", playerSpawnPt, false)


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
	

func loadNewRoom(newRoom : String, playerSpawn, playerFlipped):
	if($roomLayer.get_child_count() != 0):
		$roomLayer.get_child(0).queue_free()
	var room = generalRoomScene.instance();
	$roomLayer.add_child(room)
	room.setRoom(newRoom, playerSpawn, playerFlipped)	
	var roomDialog = roomDialog_scene.instance()
	add_child(roomDialog)
	roomDialog.play_roomDialog(newRoom, currentRoomFloor)
	
				


func loadRoom_cooldown():
	yield(get_tree().create_timer(1), "timeout")
	roomHasLoaded = false;
	
