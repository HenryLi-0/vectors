extends Node

@onready var drivetrain: RigidBody3D = $"../Drivetrain"

@onready var g_intake: RigidBody3D = $"../Drivetrain/GroundIntake"
@onready var g_top_rollers: RigidBody3D = $"../Drivetrain/GroundIntake/TopRollers"
@onready var g_bottom_rollers: RigidBody3D = $"../Drivetrain/GroundIntake/BottomRollers"
@onready var g_far_left_roller: RigidBody3D = $"../Drivetrain/GroundIntake/FarLeftRoller"
@onready var g_middle_left_roller: RigidBody3D = $"../Drivetrain/GroundIntake/MiddleLeftRoller"
@onready var g_middle_right_roller: RigidBody3D = $"../Drivetrain/GroundIntake/MiddleRightRoller"
@onready var g_far_right_roller: RigidBody3D = $"../Drivetrain/GroundIntake/FarRightRoller"

@onready var e_arm: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm"
@onready var e_back_rollers: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm/EndBackRollers"
@onready var e_front_rollers: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm/EndFrontRollers"

func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:

	g_far_left_roller.do_physics(delta)
	g_middle_left_roller.do_physics(delta)
	g_middle_right_roller.do_physics(delta)
	g_far_right_roller.do_physics(delta)
	g_top_rollers.do_physics(delta)
	g_bottom_rollers.do_physics(delta)
	g_intake.do_physics(delta)
	
	e_front_rollers.do_physics(delta)
	#e_back_rollers.do_physics(delta)
	e_arm.do_physics(delta)
	
	drivetrain.do_physics(delta)

	if Input.is_action_pressed("test"):
		#g_intake.setGoal(PI/2)
		#g_top_rollers.setPower(-1)
		#g_bottom_rollers.setPower(-1)
		#e_front_rollers.setPower(-1)
		e_arm.setGoal(0)
	else:
		#g_intake.setGoal(-PI/2)
		#g_top_rollers.setPower(1)
		#g_bottom_rollers.setPower(1)
		#e_front_rollers.setPower(1)
		e_arm.setGoal(PI/4)
	e_back_rollers.rotation.y = 0
	e_back_rollers.rotation.z = 0
	e_back_rollers.apply_torque(e_back_rollers.global_transform.basis * Vector3.RIGHT * delta)

	print(e_back_rollers.rotation.x)
