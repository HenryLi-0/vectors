extends Node

@onready var drivetrain: RigidBody3D = $"../Drivetrain"

@onready var g_intake: RigidBody3D = $"../Drivetrain/GroundIntake"
@onready var g_top_rollers: RigidBody3D = $"../Drivetrain/GroundIntake/TopRollers"
@onready var g_bottom_rollers: RigidBody3D = $"../Drivetrain/GroundIntake/BottomRollers"
@onready var g_far_left_roller: RigidBody3D = $"../Drivetrain/GroundIntake/FarLeftRoller"
@onready var g_middle_left_roller: RigidBody3D = $"../Drivetrain/GroundIntake/MiddleLeftRoller"
@onready var g_middle_right_roller: RigidBody3D = $"../Drivetrain/GroundIntake/MiddleRightRoller"
@onready var g_far_right_roller: RigidBody3D = $"../Drivetrain/GroundIntake/FarRightRoller"

@onready var elevator: RigidBody3D = $"../Drivetrain/ElevatorStageOne"
@onready var e_arm: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm"
@onready var e_back_rollers: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm/EndBackRollers"
@onready var e_front_rollers: RigidBody3D = $"../Drivetrain/ElevatorStageOne/ElevatorStageTwo/Arm/EndFrontRollers"

var CONSTANTS = preload("res://scenes/robots/1778/constants.gd")

func _ready() -> void:
	g_top_rollers.setPower(50)
	g_bottom_rollers.setPower(50)
	g_intake.setGoal(0)
	#g_far_left_roller.setPower(10)
	#g_middle_left_roller.setPower(10)
	#g_middle_right_roller.setPower(10)
	#g_far_right_roller.setPower(10)

func _process(delta: float) -> void:
	pass

func updateState(state) -> void:
	pass


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("button_x"):
		updateState(CONSTANTS.STATE.READY_C4)
	if Input.is_action_pressed("trigger_right"):
		updateState(CONSTANTS.STATE.SCORE_C4)
	#print(g_top_rollers.rotation.x)
	#g_far_left_roller.setPower(10)
	#if Input.is_action_pressed("test"):
		##g_intake.setGoal(0.87)
		##g_intake.setGoal(PI - 2.325886)
		##e_back_rollers.setPower(-1)
		#elevator.setGoalPosition(CONSTANTS.ELEVATOR_POSITIONS.L4Before * 0.0254/1.5)
		#e_arm.setGoal(CONSTANTS.ARM_POSITIONS.L4ScoreCoral * PI/180 - PI)
	#else:
		#elevator.setGoalPercent(0)
		##g_intake.setGoal(-PI/2)
		#elevator.setGoalPosition(CONSTANTS.ELEVATOR_POSITIONS.L4Score * 0.0254/1.5)
		#e_arm.setGoal(CONSTANTS.ARM_POSITIONS.L4FinishScoreCoral * PI/180 - PI)
#
#


	'''physics stuff'''
	# ground intake physics
	g_far_left_roller.do_physics(delta)
	g_middle_left_roller.do_physics(delta)
	g_middle_right_roller.do_physics(delta)
	g_far_right_roller.do_physics(delta)
	g_top_rollers.do_physics(delta)
	g_bottom_rollers.do_physics(delta)
	g_intake.do_physics(delta)
	
	# elevator and arm physics
	elevator.do_physics(delta)
	e_front_rollers.do_physics(delta)
	e_back_rollers.do_physics(delta)
	e_arm.do_physics(delta)
	
	# drivetrain
	drivetrain.do_physics(delta)	
