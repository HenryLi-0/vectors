extends Node

@onready var drivetrain: RigidBody3D = $Drivetrain
@onready var commands: Node = %Commands

'''Returns the drivetrain position.'''
func getDrivetrainPosition() -> Vector3:
	return drivetrain.position

func getAutoAlignError() -> String:
	if drivetrain.automation:
		return "Position Error: " + str(drivetrain.targetError)
	return ""

func moved() -> bool:
	return commands.moved
