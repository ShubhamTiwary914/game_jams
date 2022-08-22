extends Node2D


func setSprite(selfData):
	$Sprite.scale = selfData.furnitureSize;
	if(selfData.furnitureSprite != null):
	  $Sprite.texture =  selfData.furnitureSprite
	

