 extends KinematicBody2D


onready var worldNode = get_tree().root.get_child(0)
onready var itemSlots : Node2D;
onready var dialogBox_scene = load("res://scenes/Interactables/dialogBox.tscn")


onready var playerData = load("res://Store/playerData.tres")
onready var player = get_node(".");
onready var playerAnimatonSprite = $playerAnimation;


#Default = Magnifying_Glass
onready var itemSwapPressed = false;
onready var itemHeld = "Default";




# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = playerData.spawnPoint;
	itemSlots = worldNode.itemSlots;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerVelocity = Vector2(0,0)
	playerVelocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * playerData.speed;
	playerVelocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * playerData.speed;
	playerVelocity = move_and_slide(playerVelocity)
	playerSpriteFlip(playerVelocity)
	playerHandle_heldItem()
	playerhandleAnimations(playerVelocity)
	
	
	
	
	

func playerSpriteFlip(playerVelocity : Vector2):
	if (playerVelocity.x < 0):
		playerAnimatonSprite.flip_h = true;
	if (playerVelocity.x > 0):
		playerAnimatonSprite.flip_h = false;


func playerhandleAnimations(playerVel : Vector2):
	if !(playerVel.x == 0 and playerVel.y == 0):
		playerAnimatonSprite.play("Walk" + itemHeld)
	else:
		playerAnimatonSprite.play("Idle" + itemHeld)
 

    #   ------    ITEMS / INTERACTABLES  SECTION   ------
func playerHandle_heldItem():
	if(Input.is_action_pressed("slot1")):
		var slot1Sprite = worldNode.itemSlots.slot1Sprite;
		swapItems(1, slot1Sprite)
	if(Input.is_action_pressed("slot2")):
		var slot2Sprite = worldNode.itemSlots.slot1Sprite;
		swapItems(2, slot2Sprite)
		
func swapItems(slotPressed, spriteNode):
	if(!itemSwapPressed):
		var Holder = itemHeld
		if(slotPressed == 1):
			if(worldNode.itemSlots.slot1Value != ""):
				itemHeld = worldNode.itemSlots.slot1Value
				worldNode.itemSlots.setItemSlot(1, Holder)
		if(slotPressed == 2):
			if(worldNode.itemSlots.slot2Value != ""):
				itemHeld = worldNode.itemSlots.slot2Value
				worldNode.itemSlots.setItemSlot(2, Holder)
		itemSwapPressed = true;
		enableLighting()
		swapItem_cooldown()
	
	
func swapItem_cooldown():
	yield(get_tree().create_timer(1), "timeout")
	itemSwapPressed = false;
	
	
func enableLighting():
	if(itemHeld == "Candle"):
		$CandleLight.enabled = true;
	else:
		$CandleLight.enabled = false;
