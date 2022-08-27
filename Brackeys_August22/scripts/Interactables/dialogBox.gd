extends Node2D

onready var worldNode = get_tree().root.get_child(0)

onready var dialogText : String = "";
onready var dialogTextNode = $Control/colorRect/dialogText;
export (float) var dialogTextDelay = 0.02;



func runTextDialog(dialogTextString: String):
	dialogText = dialogTextString;
	if( (len(dialogText) - len(dialogTextNode.text)) > 0 ):
		animateTextLoad(len(dialogText) - len(dialogTextNode.text))
	



func animateTextLoad(iterations: int):
	for i in range(iterations + 1):
		yield(get_tree().create_timer(dialogTextDelay), "timeout")
		worldNode.playSound("dialogBlip")
		dialogTextNode.text += dialogText[i];
		if(i == iterations):
			worldNode.stopSound("dialogBlip")

	
	
	