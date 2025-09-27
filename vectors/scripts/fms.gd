extends Node

@onready var redReefs:Array = []
@onready var blueReefs:Array = []
@onready var ds: Node3D = $DriverStation

var redPoints:int = 0
var bluePoints:int = 0

func _ready() -> void:
	for letter in "ABCDEFGHIJKL":
		redReefs.append(get_node("Red Reef Branches/Red Reef " + letter))
		blueReefs.append(get_node("Blue Reef Branches/Blue Reef " + letter))

func _process(delta: float) -> void:
	redPoints = 0
	bluePoints = 0
	for reef in redReefs:
		redPoints += reef.getPoints()
	for reef in blueReefs:
		bluePoints += reef.getPoints()
	
	# update ds
	ds.updateRed(redPoints)
	ds.updateBlue(bluePoints)
	ds.updateDS("hehe *breaks your robot* oops")
