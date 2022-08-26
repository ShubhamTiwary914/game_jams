extends KinematicBody2D

#Data
onready var defaultTarget = [Vector2(100,100), Vector2(800, 100), Vector2(100,500), Vector2(20, 500), Vector2(400,400)]
onready var worldNode = get_tree().root.get_child(0)
onready var ghostSpeed = 100;
onready var ghostRecoilSpeed = 250;

onready var nodeisGhost = true;
onready var ghostInChase = false;
onready var playerInRange = false;
onready var ghostInRecoil = false;


#Movement
onready var ghostDirection;
onready var ghostTarget : Vector2;


func _ready():
	$AnimatedSprite.play("Travel")
	ghostChange_targetTimer()
	
	
	
func randomNumberGenerator(start, end) -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = int(rng.randf_range(start, end))
	return my_random_number
	
	

func _physics_process(delta):
	if(!worldNode.isDialogActive):
		ghostTravel()
		ghostChasePlayer()


func ghostTravel():
	if(!ghostInRecoil):
		var ghostVelocity = (ghostTarget - global_position).normalized()
		ghostVelocity = Vector2(ghostVelocity.x * ghostSpeed, ghostVelocity.y * ghostSpeed)
		ghostVelocity = move_and_slide(ghostVelocity)
		ghostSpriteFlipper(ghostVelocity)
		var targetDistance = sqrt( pow(ghostTarget.y - global_position.y ,2) + pow(ghostTarget.x - global_position.x ,2) )
		if(targetDistance <= 50):
			ghostChange_targetTimer()
	if(ghostInRecoil):
		ghostTakesRecoil(worldNode.playerCurrentPosition)
	
	
func ghostChasePlayer():
	#has candle while in chase -> stop chasing
	if(ghostInChase and worldNode.playerCurrentItem == "Candle"): 
		ghostInChase = false
	#has no candle, in chase -> keey chasing
	if(ghostInChase and worldNode.playerCurrentItem != "Candle"): 
		ghostTarget = worldNode.playerCurrentPosition
	#while not in chase, having candle -> backs off ghost
	if(playerInRange and worldNode.playerCurrentItem == "Candle"):
		ghostInRecoil = true


func ghostTakesRecoil(sourceVector):	
	var ghostVelocity = (global_position - worldNode.playerCurrentPosition).normalized()
	ghostVelocity = Vector2(ghostVelocity.x * ghostRecoilSpeed, ghostVelocity.y * ghostRecoilSpeed)
	ghostVelocity = move_and_slide(ghostVelocity)
	var targetDistance = sqrt( pow(worldNode.playerCurrentPosition.y - global_position.y ,2) + pow(worldNode.playerCurrentPosition.x - global_position.x ,2) )
	if(targetDistance >= 300):
		ghostInRecoil = false
		ghostChange_targetTimer()
	
	
	
func ghostSpriteFlipper(ghostVelocity):
	if(ghostVelocity.x <= 0):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false



func ghostChange_targetTimer(): #resets target to random every few secs
	if(!ghostInChase):
		var randomTargetIndex = randomNumberGenerator(0, len(defaultTarget))
		ghostTarget = defaultTarget[randomTargetIndex]
	
	

func _on_chaseRange_body_entered(body):
	if(body.name == "Player"):
		playerInRange = true;
		if(worldNode.playerCurrentItem != "Candle"): #no shield -> start chasing
			ghostInChase = true;

		
func _on_chaseRange_body_exited(body):
	if(body.name == "Player"):
		playerInRange = false;
