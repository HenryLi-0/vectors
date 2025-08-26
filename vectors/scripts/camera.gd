extends Camera3D

@onready var robot: Node3D = $"../1778Robot"

func _process(delta: float) -> void:
	pass
	position.z = robot.getDrivetrainPosition().z
	position.x = robot.getDrivetrainPosition().x - 9
