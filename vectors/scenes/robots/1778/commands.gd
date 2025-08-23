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

func _ready() -> void:
	g_top_rollers.setPower(10)
	g_bottom_rollers.setPower(10)
	#g_far_left_roller.setPower(10)
	#g_middle_left_roller.setPower(10)
	#g_middle_right_roller.setPower(10)
	#g_far_right_roller.setPower(10)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	#print(g_top_rollers.rotation.x)
	#g_far_left_roller.setPower(10)
	if Input.is_action_pressed("test"):
		g_intake.setGoal(0.87)
		#g_intake.setGoal(PI - 2.325886)
		#e_back_rollers.setPower(-1)
		e_arm.setGoal(-PI/2)
	else:
		g_intake.setGoal(-PI/2)
		e_arm.setGoal(PI/4)

	g_far_left_roller.do_physics(delta)
	g_middle_left_roller.do_physics(delta)
	g_middle_right_roller.do_physics(delta)
	g_far_right_roller.do_physics(delta)
	g_top_rollers.do_physics(delta)
	g_bottom_rollers.do_physics(delta)
	g_intake.do_physics(delta)
	
	e_front_rollers.do_physics(delta)
	e_back_rollers.do_physics(delta)
	e_arm.do_physics(delta)
	
	drivetrain.do_physics(delta)	
