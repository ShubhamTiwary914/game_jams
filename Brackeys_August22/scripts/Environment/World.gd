extends Node2D

export (String) var spawnRoom = "attic";

onready var menuScene = load("res://scenes/Interactables/menu.tscn")
onready var generalRoomScene = load("res://scenes/Rooms/GeneralRoom.tscn")
onready var itemSlots = $itemSlots;

onready var actionBtns = $actionBtns;
onready var useBtn = load("res://scenes/Interactables/UseButton.tscn")
onready var roomDialog_scene = load("res://scenes/Interactables/roomDialog.tscn")

#UI
onready var gameControlsNode = $gameControls;
onready var mouseCurrentTarget = "";
onready var dialogBoard = $dialogBoard;
onready var isDialogActive = false;
onready var playerhasDied = false;


#Player 
onready var playerSpawnPt;
onready var playerCurrentPosition = Vector2.ZERO;
onready var playerCurrentItem = "Default";
onready var playerFlippedX = false;
onready var playerHasCandle = true;
onready var playerHasKey = false;
onready var playerHp = 3;

#Ghost
onready var maxGhostCount = 1;

#Items
onready var itemDurabilityVisible = false;
onready var itemResetDurability = false;

#Rooms / Keys
onready var roomHasLoaded = false;
onready var currentRoomFloor : String;
onready var currentRoom : String;
onready var itemBlackList = [];
onready var keyBlackList = []
onready var unlockedDoors = []



func _ready():
	gameControlsNode.loadGame_startMenu()


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
	if(!playerhasDied):
		if(isDialogActive):
			dialogBoard.get_child(0).queue_free()
			stopSound("dialogBlip")
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
	

func destroyFurniture(furnitureName):
	$roomLayer.get_child(0).destroyFurniture(furnitureName)


func _on_raiseGhostCount_timer():
	maxGhostCount += 1;


func restartGameMenu(completeEnd = false):
	playerhasDied = true;
	isDialogActive = true
	playerCurrentItem = "Default"
	var menuBoard = menuScene.instance()
	add_child(menuBoard)
	if(!completeEnd):
		menuBoard.setDeathview("You Died!")
	else:
		menuBoard.setDeathview("Game Over!")
	
	
	

func playSound(soundName: String):
	var soundSlot = $sounds.get_node(soundName)
	if(!soundSlot.playing):
		soundSlot.stream = load("res://assets/Sounds/" + soundName + ".wav")
		soundSlot.play()


func stopSound(soundName: String):
	var soundSlot = $sounds.get_node(soundName)
	soundSlot.playing = false;
	
	
	
func _on_backgroundMusic_finished():
	$sounds/backgroundMusic.playing = true
