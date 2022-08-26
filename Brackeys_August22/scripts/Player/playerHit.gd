extends "res://scripts/Player/PlayerMain.gd"


onready var hpEmpty = load("res://assets/UI/HeartUIEmpty.png")


func _ready():
	setHealthSprites()


func _on_playerHitbox_body_entered(body):
	if(body.get("nodeisGhost") == true):
		body.ghostInRecoil = true;
		body.ghostTakesRecoil(global_position)
		body.ghostChange_targetTimer()
		playerIsHit = true
		reducePlayerHp()
		

func setHealthSprites():
	for healthIndex in range(0, playerData.playerMaxHp):
		if( healthIndex >= worldNode.playerHp ):
			$health.get_child(healthIndex).texture = hpEmpty;
		

func reducePlayerHp():
	worldNode.playerHp -= 1;
	if(worldNode.playerHp > 0):
		$health.get_child(worldNode.playerHp).texture = hpEmpty;
	else:
		playerDies()
	

func playerDies():
	print("you died!")
		 
		
		

