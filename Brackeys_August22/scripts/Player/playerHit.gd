extends "res://scripts/Player/PlayerMain.gd"


onready var hpEmpty = load("res://assets/UI/HeartUIEmpty.png")




func _on_playerHitbox_body_entered(body):
	if(body.get("nodeisGhost") == true):
		body.ghostInRecoil = true;
		body.ghostTakesRecoil(global_position)
		body.ghostChange_targetTimer()
		playerIsHit = true
		reducePlayerHp()
		
		

func reducePlayerHp():
	worldNode.playerHp -= 1;
	$health.get_child(worldNode.playerHp).texture = hpEmpty;
	

func playerDies():
	pass
		 
		
		

