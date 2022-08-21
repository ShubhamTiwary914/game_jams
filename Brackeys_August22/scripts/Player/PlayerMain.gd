extends KinematicBody2D


onready var playerData = load("res://Store/playerData.tres")
onready var player = get_node(".");



# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = playerData.spawnPoint;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerVelocity = Vector2(0,0)
	playerVelocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * playerData.speed;
	playerVelocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * playerData.speed;
	playerVelocity = move_and_slide(playerVelocity)
	


