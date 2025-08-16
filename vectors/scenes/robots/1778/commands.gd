extends Node

@onready var end_back_rollers: RigidBody3D = $"../ElevatorStageOne/ElevatorStageTwo/Arm/EndBackRollers"
@onready var end_front_rollers: RigidBody3D = $"../ElevatorStageOne/ElevatorStageTwo/Arm/EndFrontRollers"
@onready var arm: RigidBody3D = $"../ElevatorStageOne/ElevatorStageTwo/Arm"
const GOAL:int = 1

func _physics_process(delta: float) -> void:
	#print(arm.rotation_degrees.z)
	#arm.rotation.z = -PI/6
	if Input.is_action_pressed("test"):
		arm.constant_torque = Vector3(0,0,(-PI/6 - arm.rotation.z) * delta * 0.1)
		end_front_rollers.apply_torque(end_front_rollers.global_transform.basis * Vector3.RIGHT * -delta)
		end_back_rollers.apply_torque(end_front_rollers.global_transform.basis * Vector3.RIGHT * delta)
	else:
		arm.constant_torque = Vector3.ZERO
		end_front_rollers.constant_torque = Vector3.ZERO
		end_back_rollers.constant_torque = Vector3.ZERO
		end_front_rollers.angular_velocity *= 0.7
		end_back_rollers.angular_velocity *= 0.7
