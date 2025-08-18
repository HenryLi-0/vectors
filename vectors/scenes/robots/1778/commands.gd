extends Node

@onready var drivetrain: RigidBody3D = $"../Drivetrain"
@onready var end_back_rollers: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm/EndBackRollers"
@onready var end_front_rollers: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm/EndFrontRollers"
@onready var arm: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm"
const GOAL:int = 1
var sus:bool = false

func _process(delta: float) -> void:
	if not(sus):
		arm.rotation.z = -PI/4
		sus = true


func _physics_process(delta: float) -> void:
	end_front_rollers.rotation.y = 0
	end_front_rollers.rotation.z = 0
	end_back_rollers.rotation.y = 0
	end_back_rollers.rotation.z = 0
	arm.rotation.x = 0
	arm.rotation.y = 0
	
	drivetrain.do_physics(delta)
	arm.do_physics(delta)
	end_front_rollers.do_physics(delta)
	#print(arm.rotation.z)
	##arm.rotation.z = M
	#if Input.is_action_pressed("test"):
		#arm.apply_torque(arm.global_transform.basis * Vector3.BACK * delta * (0 - arm.rotation.z) * 1)
		#end_front_rollers.apply_torque(end_front_rollers.global_transform.basis * Vector3.RIGHT * -delta)
		#end_back_rollers.apply_torque(end_back_rollers.global_transform.basis * Vector3.RIGHT * delta)
		##end_front_rollers.apply_torque(end_front_rollers.global_transform.rotated_local(Vector3.RIGHT, 60).basis.x * -delta)
		##end_back_rollers.apply_torque(end_back_rollers.global_transform.rotated_local(Vector3.RIGHT, 60).basis.x * delta)
		##end_front_rollers.apply_torque(drivetrain.transform.basis * arm.transform.basis * Vector3.RIGHT * -delta)
		##end_back_rollers.apply_torque(drivetrain.transform.basis * arm.transform.basis * Vector3.RIGHT * delta)
	#else:
		##arm.constant_torque = Vector3.ZERO
		#end_front_rollers.constant_torque = Vector3.ZERO
		#end_back_rollers.constant_torque = Vector3.ZERO
		#end_front_rollers.angular_velocity *= 0.7
		#end_back_rollers.angular_velocity *= 0.7
	
