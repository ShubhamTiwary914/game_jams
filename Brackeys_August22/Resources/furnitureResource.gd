extends Resource 
class_name furnitureResource

#general
export (String) var furnitureName;
export (Image) var furnitureSprite;
export (Vector2) var spawnPosition;
export (Vector2) var furnitureSize;
export (Array, String) var dialogSet; 
export (bool) var hasKey = false;


#light
export (String) var furnitureType;
export (float) var lightIntensity;
export (float) var lightRange;

#door
export (String) var doorRoom;
export (bool) var door_isLocked;
export (bool) var doorIsRight;


