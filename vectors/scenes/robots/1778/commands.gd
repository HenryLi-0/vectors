extends Node

@onready var end_back_rollers: RigidBody3D = $"../ElevatorStageOne/ElevatorStageTwo/Arm/EndBackRollers"
@onready var end_front_roller: RigidBody3D = $"../ElevatorStageOne/ElevatorStageTwo/Arm/EndFrontRoller"

func _process(delta: float) -> void:
	if Input.is_action_pressed("test"):
		end_front_roller.add_constant_torque(Vector3(-1 * delta,0,0))
		end_back_rollers.add_constant_torque(Vector3( 1 * delta,0,0))
