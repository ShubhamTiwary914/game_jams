 extends KinematicBody2D


onready var worldNode = get_tree().root.get_child(0)
onready var itemSlots : Node2D;


onready var playerData = load("res://Store/playerData.tres")
onready var player = get_node(".");
onready var playerAnimatonSprite = $playerAnimation;


#Default = Magnifying_Glass
onready var itemSwapPressed = false;
#onready var itemHeld = "Default";
onready var furnitureInteractable = "";


onready var mouseHasClicked = false;
onready var playerIsHit = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = playerData.spawnPoint;
	itemSlots = worldNode.itemSlots;
	enableLighting()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerVelocity = Vector2(0,0)
	playerVelocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * playerData.speed;
	playerVelocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * playerData.speed;
	playerVelocity = move_and_slide(playerVelocity)
	worldNode.playerCurrentPosition = global_position;
	playerSpriteFlip(playerVelocity)
	playerHandle_heldItem()
	playerhandleAnimations(playerVelocity, delta)
	mouseClickHandler()
	dialogClick_handler()
	
	
	
	 #   ------    SPRITES / ANIMATION  SECTION   ------

func playerSpriteFlip(playerVelocity : Vector2):
	if (playerVelocity.x < 0):
		playerAnimatonSprite.flip_h = true;
	if (playerVelocity.x > 0):
		playerAnimatonSprite.flip_h = false;



func playerhandleAnimations(playerVel : Vector2, delta):
	if(!playerIsHit):
		if !(playerVel.x == 0 and playerVel.y == 0):
			playerAnimatonSprite.play("Walk" + worldNode.playerCurrentItem)
		else:
			playerAnimatonSprite.play("Idle" + worldNode.playerCurrentItem)
	else:
		playerData.playerHitTimer -= delta
		playerAnimatonSprite.play("Hit")
		if(playerData.playerHitTimer <= playerData.playerHitDuration):
			playerIsHit = false;
		
 



    #   ------    ITEMS  SECTION   ------
func playerHandle_heldItem():
	if(Input.is_action_pressed("slot1")):
		if(worldNode.playerHasCandle):
			var slot1Sprite = worldNode.itemSlots.slot1Sprite;
			swapItems(1, slot1Sprite)	
		
		
func swapItems(slotPressed, spriteNode):
	if(!itemSwapPressed):
		var Holder = worldNode.playerCurrentItem
		if(slotPressed == 1):
			if(worldNode.itemSlots.slot1Value != ""):
				worldNode.playerCurrentItem = worldNode.itemSlots.slot1Value
				$itemDurability.playerChangedItems()
				worldNode.itemSlots.setItemSlot(1, Holder)
		itemSwapPressed = true;
		enableLighting()
		swapItem_cooldown()
	
	
func swapItem_cooldown():
	yield(get_tree().create_timer(playerData.itemSwap_cooldown), "timeout")
	itemSwapPressed = false;
	
	
func enableLighting():
	if(worldNode.playerHasCandle):
		if(worldNode.playerCurrentItem == "Candle"):
			$CandleLight.enabled = true;
		else:
			$CandleLight.enabled = false;
	else:
		$CandleLight.enabled = false;
		




  #   ------    INTERACTABLES  SECTION   ------
func onFurniture_rangeEntered(furnitureData, collisionType):
	if(furnitureData != null):
		if(collisionType == "enter"):
			worldNode.createInteractive_button(furnitureData)
		else:
			worldNode.destroyInteractive_button(furnitureData.furnitureName)
	
			
func mouseClickHandler():
	if(Input.is_action_pressed("mouseClick")):
		worldNode.playerFlippedX = $playerAnimation.flip_h
		if(!mouseHasClicked):
			worldNode.interactiveMouse_clicked()
			mouseHasClicked = true;
			mouseClick_cooldown()

	
func mouseClick_cooldown():
	yield(get_tree().create_timer(playerData.mouseClick_cooldown), "timeout")
	mouseHasClicked = false;
		

func dialogClick_handler():
	if(Input.is_action_pressed("dialogSkip")):
		worldNode.skipDialog()
			
		
		
	