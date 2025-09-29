extends Node

@onready var redReefs:Array = []
@onready var blueReefs:Array = []
@onready var ds: Node3D = $DriverStation
@onready var robot: Node3D = $"../1778Robot"
@onready var timer: Timer = $Timer

var redPoints:int = 0
var bluePoints:int = 0

func _ready() -> void:
	for letter in "ABCDEFGHIJKL":
		redReefs.append(get_node("Red Reef Branches/Red Reef " + letter))
		blueReefs.append(get_node("Blue Reef Branches/Blue Reef " + letter))
	ds.updateRed(0)
	ds.updateBlue(0)
	ds.updateDS("")
	timer.paused = true

func _process(delta: float) -> void:
	if timer.paused:
		if robot.moved():
			timer.paused = false
	redPoints = 0
	bluePoints = 0
	for reef in redReefs:
		redPoints += reef.getPoints()
	for reef in blueReefs:
		bluePoints += reef.getPoints()
	
	# update ds**
	ds.updateRed(redPoints)
	ds.updateBlue(bluePoints)
	ds.updateTimer(timer.time_left)
	if robot.getAutoAlignError() != "":
		ds.updateDS(robot.getAutoAlignError())
