extends Node

@export var drivetrain:RigidBody3D

'''Returns the drivetrain position.'''
func getDrivetrainPosition() -> Vector3:
	return drivetrain.position
