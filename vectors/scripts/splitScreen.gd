extends Node3D

@onready var left: Camera3D = $GridContainer/LeftSubViewportContainer/LeftSubViewport/left
@onready var right: Camera3D = $GridContainer/RightSubViewportContainer/RightSubViewport/right

func _ready() -> void:
	left.position = position
	left.rotation = rotation
	#right.position = position
	#right.rotation = rotation
	
	## above blue reef
	#right.position = Vector3(-4.45, 4.5, 0.0)
	#right.rotation = Vector3(-PI/2,-PI/2,0)
	right.position = Vector3(-5.15, 3.1, -0.15)
	right.rotation = Vector3(-PI/2,-PI/2,0)
