extends Node2D

onready var lightTexture = load("res://assets/Items/lightTexture.png")
onready var shadowTexture = load("res://assets/Items/shadow.png")

onready var furnitureData;

func setSprite(selfData):
	$Sprite.scale = selfData.furnitureSize;
	if(selfData.furnitureSprite != null):
		$Sprite.texture =  selfData.furnitureSprite
		furnitureData = selfData
	activateLightSource(selfData)

	
func activateLightSource(selfData):
	if(selfData.furnitureType == "light"):
		var lightNode = Light2D.new()
		lightNode.texture = lightTexture;
		lightNode.energy = selfData.lightIntensity;
		lightNode.scale = Vector2(selfData.lightRange, selfData.lightRange)
		add_child(lightNode)
		

	

func _on_furnitureArea_body_entered(body):
	if(body.name == "Player"):
		body.onFurniture_rangeEntered(furnitureData, "enter")
		
		
func _on_furnitureArea_body_exited(body):
	if(body.name == "Player"):
		body.onFurniture_rangeEntered(furnitureData, "exit")
