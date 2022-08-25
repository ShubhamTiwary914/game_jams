extends TextureProgress


onready var worldNode = get_tree().root.get_child(0)
onready var playerData = load("res://Store/playerData.tres")


func _ready():
	$".".visible = worldNode.itemDurabilityVisible


func _physics_process(delta):
	reduceCandle_durability(delta)
	resetCandleDurability()
	
	
func playerChangedItems():
	if(worldNode.playerCurrentItem == "Default"):
		$".".visible = false
		worldNode.itemSlots.setItemDurability(true, playerData.candleDurability)
	else:
		$".".visible = true
		worldNode.itemDurabilityVisible = true;
		worldNode.itemSlots.setItemDurability(false, playerData.candleDurability)
		
	
	
func reduceCandle_durability(delta):
	if(worldNode.playerCurrentItem == "Candle"):
		playerData.candleDurability -= delta * 3.33
	$".".value = playerData.candleDurability
	if(playerData.candleDurability <= 0):
		worldNode.playerHasCandle = false
		worldNode.itemSlots.visible = false
		$".".visible = false;
		worldNode.playerCurrentItem = "Default"
		get_parent().enableLighting()

	
	
func resetCandleDurability():
	if(worldNode.itemResetDurability):
		playerData.candleDurability = 100
		if(worldNode.playerCurrentItem == "Default"):
			worldNode.itemSlots.setItemDurability(true, playerData.candleDurability)
		worldNode.itemResetDurability = false;
		
	
	
