extends Node

@onready var drivetrain: RigidBody3D = $"../Drivetrain"

@onready var g_detection: Area3D = $"../GroundIntake/detection"
@onready var g_intake: RigidBody3D = $"../GroundIntake"
@onready var g_top_rollers: RigidBody3D = $"../GroundIntakeRollers/TopRollers"
@onready var g_bottom_rollers: RigidBody3D = $"../GroundIntakeRollers/BottomRollers"
@onready var g_far_left_roller: RigidBody3D = $"../GroundIntakeRollers/FarLeftRoller"
@onready var g_middle_left_roller: RigidBody3D = $"../GroundIntakeRollers/MiddleLeftRoller"
@onready var g_middle_right_roller: RigidBody3D = $"../GroundIntakeRollers/MiddleRightRoller"
@onready var g_far_right_roller: RigidBody3D = $"../GroundIntakeRollers/FarRightRoller"

@onready var elevator: Node3D = $"../Elevator"
@onready var e_arm: RigidBody3D = $"../Arm"
@onready var e_detection: Area3D = $"../Arm/detection"
@onready var e_back_rollers: RigidBody3D = $"../EndEffector/EndBackRollers"
@onready var e_front_rollers: RigidBody3D = $"../EndEffector/EndFrontRollers"

var CONSTANTS = preload("res://scenes/robots/1778/constants.gd")
var currentState

# debug
var temp

func _ready() -> void:
	currentState = CONSTANTS.STATE.IDLE
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
	currentState = state
	var slice = CONSTANTS.STATE_POSITIONS[state]
	# GROUND INTAKE RAISED?, GROUND ROLLER DIRECTION, ELEVATOR (INCHES), ARM (DEGREES), ARM ROLLERS DIRECTION
	if str(slice[0]) != "idc":
		# ground intake raised?
		if slice[0]: g_intake.setGoal(-PI/2)
		else: g_intake.setGoal(0.87)
		g_detection.setActive(not(slice[0]))
	if str(slice[1]) != "idc":
		# ground roller direction (-1 is in)
		g_top_rollers.setPower(-1000 * slice[1])
		g_bottom_rollers.setPower(-1000 * slice[1])
	if str(slice[2]) != "idc":
		# elevator (inches -> meters)
		elevator.setGoalPosition(slice[2] * CONSTANTS.ELEVATOR_CONVERSION)
	if str(slice[3]) != "idc":
		# arm (degrees -> radians, with offset added)
		e_arm.setGoal(slice[3] * CONSTANTS.ARM_CONVERSION + CONSTANTS.ARM_OFFSET)
	if str(slice[4]) != "idc":
		# arm rollers direction (-1 is in)
		e_front_rollers.setPower(-100 * slice[4])
		e_back_rollers.setPower(-100 * slice[4])
		e_detection.setActive(slice[4] < 0)
		


func _physics_process(delta: float) -> void:
	'''SCORING'''
	if Input.is_action_pressed("button_y"):
		updateState(CONSTANTS.STATE.READY_C4)
	if Input.is_action_pressed("button_x"):
		updateState(CONSTANTS.STATE.READY_C3)
	if Input.is_action_pressed("button_b"):
		updateState(CONSTANTS.STATE.READY_C2)
	if Input.is_action_pressed("trigger_right"):
		if currentState == CONSTANTS.STATE.READY_C4 or currentState == CONSTANTS.STATE.READY_C3 or currentState == CONSTANTS.STATE.READY_C2:
			updateState(CONSTANTS.READY_SCORE_MAP[currentState])
			e_detection.drop()

	'''INTAKING'''
	if Input.is_action_just_pressed("trigger_left"):
		g_detection.drop()
	if Input.is_action_pressed("trigger_left"):
		updateState(CONSTANTS.STATE.INTAKE)
	if Input.is_action_just_released("trigger_left"):
		updateState(CONSTANTS.STATE.LIFTINTAKE)
	
	'''TRANSFER'''
	if currentState == CONSTANTS.STATE.INTAKE and g_detection.isControlling():
		updateState(CONSTANTS.STATE.PRETRANSFER)
	if Input.is_action_pressed("button_a"):
		updateState(CONSTANTS.STATE.PRETRANSFER)
	if Input.is_action_pressed("d_pad_up"):
		updateState(CONSTANTS.STATE.TRANSFER)
	if Input.is_action_just_released("d_pad_up"):
		g_detection.drop()
	
	'''AUTO ALIGNING'''
	if Input.is_action_pressed("bumper_left") or Input.is_action_pressed("bumper_right"):
		var min = 99999
		var minTag
		var minTagPosition:Vector2
		for tag in CONSTANTS.REEF_TAGS:
			temp = Vector3(CONSTANTS.REEF_TAG_SCALE*(tag[1]-CONSTANTS.REEF_TAG_X_OFFSET),
					   CONSTANTS.REEF_TAG_SCALE*(tag[3])+2,
					   CONSTANTS.REEF_TAG_SCALE*(tag[2]-CONSTANTS.REEF_TAG_Z_OFFSET))
			if min > temp.distance_to(drivetrain.global_position):
				min = temp.distance_to(drivetrain.global_position)
				minTag = tag
				minTagPosition = Vector2(temp.x, temp.z)
			# tag 18 -5.116576, 0.0127
		var translate:Vector2 # xz
		if Input.is_action_pressed("bumper_left"):	translate = Vector2(-0.483424, -0.4117)
		if Input.is_action_pressed("bumper_right"):	translate = Vector2(-0.483424, -0.0837)
		translate = translate.rotated(deg_to_rad(minTag[4] + 180)) + minTagPosition
		drivetrain.setAuto(translate.x, translate.y, deg_to_rad(180 - minTag[4]))
		print("TARGET: ", translate, deg_to_rad(180 - minTag[4]))
		print("POSITION: ", drivetrain.global_position, drivetrain.global_rotation.y)
		
		#temp = preload("res://scenes/gamepieces/coral.tscn").instantiate()
		#add_child(temp)
		#temp.position = Vector3(translate.x, 2, translate.y)

	if Input.is_action_just_released("bumper_left") or Input.is_action_just_released("bumper_right"):
		drivetrain.stopAuto()
		
	'''DEBUG'''
	if Input.is_action_just_pressed("summon"):
		#temp = preload("res://scenes/gamepieces/coral.tscn").instantiate()
		#add_child(temp)
		#temp.position = drivetrain.global_position + Vector3(0, 3, 0)
		for coral in CONSTANTS.REEF_TAGS:
			temp = preload("res://scenes/gamepieces/coral.tscn").instantiate()
			add_child(temp)
			# ID,X,Z,Y,Z-Rotation,X-Rotation
			temp.position = Vector3(CONSTANTS.REEF_TAG_SCALE*(coral[1]-CONSTANTS.REEF_TAG_X_OFFSET),
									CONSTANTS.REEF_TAG_SCALE*(coral[3])+2,
									CONSTANTS.REEF_TAG_SCALE*(coral[2]-CONSTANTS.REEF_TAG_Z_OFFSET))
			print(temp.position)

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
	
	# forced numbers
	e_arm.rotation.x = drivetrain.rotation.x
	e_arm.rotation.y = drivetrain.rotation.y
