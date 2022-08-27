extends Node2D

#start = start menu,   end = end game menu
onready var mode = "start";
onready var currentItem = 0;
onready var startList = ["Start", "Controls", "Exit"]


onready var worldNode = get_tree().root.get_child(0)
onready var cursor_cooldownTimer = 0.5
onready var cursorinCooldown = false;

onready var inControlsView = false;

onready var inDeathView = false;

func _ready():
	if(mode == "end"):
		startList[0] = "Restart"
		$SelectionList/item_1/label_1.text = "Restart"


func _physics_process(delta):
	controlsInput()
	onEnterPressed()
	
	
#in menu
func controlsInput():
	if(!inControlsView and !inDeathView):
		if(Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W)):	
			if(!cursorinCooldown):
				currentItem -= 1
				cursorinCooldown = true
				cursorCoolDownTimer()
				worldNode.playSound("buttonClick")
		elif(Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S)):
			if(!cursorinCooldown):
				currentItem += 1
				cursorinCooldown = true
				cursorCoolDownTimer()
				worldNode.playSound("buttonClick")
		if(currentItem >= 2): currentItem = 2
		if(currentItem <= 0): currentItem = 0
		$cursor.global_position.y = $SelectionList.get_child(currentItem).global_position.y + 30
	if(inControlsView and !inDeathView):
		controlsView()
	if(inDeathView):
		deathView()



#select a menu option
func onEnterPressed():
	if(Input.is_key_pressed(KEY_ENTER)):
		match startList[currentItem]:
			"Start":
				worldNode.gameControlsNode.startGame();
				queue_free();
			"Restart":
				worldNode.gameControlsNode.startGame();
				queue_free();
			"Controls":
				$ControlsNote.visible = true;
				$SelectionList.visible = false;
				$cursor.visible = false
				inControlsView = true;
			"Exit":
				exitGame()
	
func setDeathview(endText = "You Died!"):
	var deathText = endText + "\n\n\n\n\n           Restart(X)"
	$ControlsNote.visible = false;
	$SelectionList.visible = false;
	$cursor.visible = false
	$deathNote.visible = true;
	inControlsView = false;
	inDeathView = true;
	$deathNote.text = deathText
	


#viewing game Controls
func controlsView():
	if(Input.is_key_pressed(KEY_X)):
		worldNode.playSound("buttonClick")
		inControlsView = false
		$ControlsNote.visible = false;
		$SelectionList.visible = true;
		$cursor.visible = true;
		$deathNote.visible = false;
		

func deathView():
	if(Input.is_key_pressed(KEY_X)):
		get_tree().reload_current_scene()


#exit game
func exitGame():
	get_tree().quit()
		

func cursorCoolDownTimer():
	yield(get_tree().create_timer(cursor_cooldownTimer), "timeout")	
	cursorinCooldown = false
	
	
	



			
	
	
	


