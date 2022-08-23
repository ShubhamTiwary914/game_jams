extends Node2D

onready var slot1Sprite = $slot_1/holder/slot1_sprite;
onready var slot2Sprite = $slot_2/holder/slot2_sprite; 

onready var slot1Value = "Candle"
onready var slot2Value = ""


onready var itemSprites = {
	"Candle": load("res://assets/holdableItems/candle.png"),
	"Default" : load("res://assets/holdableItems/magnifyingGlass.png")
}



func setItemSlot(slotNum, slotValue):
	if(slotNum == 1):
		slot1Value = slotValue;
		slot1Sprite.texture = itemSprites[slotValue];
	else:
		pass
		
