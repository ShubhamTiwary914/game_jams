extends Node2D

onready var furnitureData;
onready var thisBtn;

onready var worldNode = get_tree().root.get_child(0)
onready var dialogBox_scene = load("res://scenes/Interactables/dialogBox.tscn")

onready var hoverBtnFrame = load("res://assets/Character/itemSlotHover.png")
onready var defaultBtnFrame = load("res://assets/Character/itemSlot.png")



func _ready():
	thisBtn = get_node(".")
	thisBtn.global_position = furnitureData.spawnPosition;
	$holder/item.texture = furnitureData.furnitureSprite;


func _on_Area2D_mouse_entered():
	$holder.texture = hoverBtnFrame
	worldNode.mouseCurrentTarget = furnitureData.furnitureName


func _on_Area2D_mouse_exited():
	$holder.texture = defaultBtnFrame
	worldNode.mouseCurrentTarget = "";
	

func _on_mouseClicked():
	if(len(furnitureData.dialogSet) > 0):
		var dialogBox = dialogBox_scene.instance()
		worldNode.dialogBoard.add_child(dialogBox)
		worldNode.isDialogActive = true;
		dialogBox.runTextDialog(furnitureData.dialogSet[worldNode.randomNumberGenerator(0, len(furnitureData.dialogSet))])
	
	
