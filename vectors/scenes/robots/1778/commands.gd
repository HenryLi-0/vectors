extends Node

@onready var end_back_rollers: RigidBody3D = $"../ElevatorStageOne/ElevatorStageTwo/Arm/EndBackRollers"
@onready var end_front_rollers: RigidBody3D = $"../ElevatorStageOne/ElevatorStageTwo/Arm/EndFrontRollers"
@onready var arm: RigidBody3D = $"../ElevatorStageOne/ElevatorStageTwo/Arm"
const GOAL:int = 1

func _physics_process(delta: float) -> void:
	#print(arm.rotation_degrees.z)
	print(end_front_rollers.angular_velocity.x)
	if Input.is_action_pressed("test"):
		arm.constant_torque = Vector3(0,0,(-PI/6 - arm.rotation.z) * delta * 0.2)
		end_front_rollers.add_constant_torque(Vector3(-1 * delta,0,0))
		end_back_rollers.add_constant_torque(Vector3( 1 * delta,0,0))
	else:
		arm.constant_torque = Vector3.ZERO
		end_front_rollers.constant_torque = Vector3.ZERO
		end_back_rollers.constant_torque = Vector3.ZERO
		end_front_rollers.angular_velocity *= 0.7
		end_back_rollers.angular_velocity *= 0.7
