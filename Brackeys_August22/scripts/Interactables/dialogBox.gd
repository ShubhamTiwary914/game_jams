extends Node2D

onready var dialogText : String = "";
onready var dialogTextNode = $Control/colorRect/dialogText;
export (float) var dialogTextDelay = 0.3;



func runTextDialog(dialogTextString: String):
	dialogText = dialogTextString;
	if( (len(dialogText) - len(dialogTextNode.text)) > 0 ):
		animateTextLoad(len(dialogText) - len(dialogTextNode.text))
	



func animateTextLoad(iterations: int):
	for i in range(iterations + 1):
		yield(get_tree().create_timer(dialogTextDelay), "timeout")
		dialogTextNode.text += dialogText[i];
	
	
	
	