extends Node2D

onready var furnitureData;
onready var thisBtn;

onready var worldNode = get_tree().root.get_child(0)
onready var dialogBox_scene = load("res://scenes/Interactables/dialogBox.tscn")

onready var hoverBtnFrame = load("res://assets/Character/itemSlotHover.png")
onready var defaultBtnFrame = load("res://assets/Character/itemSlot.png")



func _ready():
	thisBtn = get_node(".")
	thisBtn.global_position = furnitureData.spawnPosition;
	$holder/item.texture = furnitureData.furnitureSprite;


func _on_Area2D_mouse_entered():
	$holder.texture = hoverBtnFrame
	worldNode.mouseCurrentTarget = furnitureData.furnitureName


func _on_Area2D_mouse_exited():
	$holder.texture = defaultBtnFrame
	worldNode.mouseCurrentTarget = "";
	

func _on_mouseClicked():
	if(furnitureData.furnitureType == "door"):
		doorClick_handler()
	elif(furnitureData.furnitureType == "candle"):
		worldNode.destroyFurniture(furnitureData.furnitureName)
		worldNode.itemResetDurability = true;
	else:
		if(furnitureData.hasKey and !worldNode.keyBlackList.has(furnitureData.furnitureName) ):
			keyHandler()
		else:
			if(len(furnitureData.dialogSet) > 0):
				var dialogText = furnitureData.dialogSet[worldNode.randomNumberGenerator(0, len(furnitureData.dialogSet))]
				dialogSet_handler(dialogText)
		
	
func doorClick_handler():
	if(!worldNode.unlockedDoors.has(furnitureData.furnitureName)):
		if(furnitureData.door_isLocked && !worldNode.playerHasKey):  #key not in hand
			dialogSet_handler("Door is Locked! Look for a key...")
		if(furnitureData.door_isLocked && worldNode.playerHasKey):  #key in hand(open)
			dialogSet_handler("The Door has Opened!")
			worldNode.unlockedDoors.append(furnitureData.furnitureName)
			worldNode.playerHasKey = false;
			worldNode.itemSlots.setKeySlot(false)
			
	if(!furnitureData.door_isLocked or worldNode.unlockedDoors.has(furnitureData.furnitureName)):  #door is open
		if(!worldNode.roomHasLoaded):
				worldNode.roomHasLoaded = true;
				var spawnPt = worldNode.playerSpawnPt;
				if(furnitureData.doorIsRight):
					spawnPt.x = 50;
				else:
					spawnPt.x = 850
				worldNode.loadNewRoom(furnitureData.doorRoom, spawnPt, worldNode.playerFlippedX)
				worldNode.loadRoom_cooldown()	



func dialogSet_handler(dialogText):
	var dialogBox = dialogBox_scene.instance()
	worldNode.dialogBoard.add_child(dialogBox)
	worldNode.isDialogActive = true;
	dialogBox.runTextDialog(dialogText)
	

	

func keyHandler():
	worldNode.playerHasKey = true
	worldNode.itemSlots.setKeySlot(true)
	dialogSet_handler("You found a Key!")
	worldNode.keyBlackList.append(furnitureData.furnitureName)
	
