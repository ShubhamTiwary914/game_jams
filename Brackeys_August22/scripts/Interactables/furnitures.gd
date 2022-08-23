extends Node2D

onready var lightTexture = load("res://assets/Items/lightTexture.png")
onready var shadowTexture = load("res://assets/Items/shadow.png")

func setSprite(selfData):
	$Sprite.scale = selfData.furnitureSize;
	if(selfData.furnitureSprite != null):
	  $Sprite.texture =  selfData.furnitureSprite
	activateLightSource(selfData)

	
func activateLightSource(selfData):
	if(selfData.furnitureType == "light"):
		var lightNode = Light2D.new()
		lightNode.texture = lightTexture;
		lightNode.energy = selfData.lightIntensity;
		lightNode.scale = Vector2(selfData.lightRange, selfData.lightRange)
		add_child(lightNode)
		

	

