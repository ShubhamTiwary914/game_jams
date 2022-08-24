extends Node2D


export (float) var animationDuration = 0.6;
export (float) var dialogLife = 1.5;
export (int) var animationYRange = 140;

	
func play_roomDialog(roomName : String, roomFloor: String):
	$roomLabel.text = roomName + "  -  " + roomFloor + " Floor "
	$Tween.interpolate_property(get_node("."), "position",
        Vector2(0, 0), Vector2(0, animationYRange), animationDuration,
        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_roomDialog_completed(object, key):
	yield(get_tree().create_timer(dialogLife), "timeout")
	queue_free()
