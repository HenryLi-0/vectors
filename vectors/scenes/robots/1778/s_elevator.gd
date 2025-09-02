extends Node3D

@export var kStageOneP:float = 6000
@export var kStageOneI:float = 0
@export var kStageOneD:float = 3000

@export var kStageTwoP:float = 6000
@export var kStageTwoI:float = 0
@export var kStageTwoD:float = 3000

var CONSTANTS = preload("res://scenes/robots/1778/constants.gd")
@onready var stageOne: RigidBody3D = $ElevatorStageOne
@onready var stageTwo: RigidBody3D = $ElevatorStageTwo

class PIDController:
	var p: float
	var i: float
	var d: float
	var lastMeasurement: float
	var lastError: float
	var totalError: float
	
	func _init(p:float, i:float, d:float, measurement:float = 0) -> void:
		self.p = p
		self.i = i
		self.d = d
		self.lastMeasurement = measurement
		self.lastError = 0
		self.totalError = 0
	func calculate(measurement:float, goal:float, deltaTime:float) -> float:
		self.totalError += (goal-measurement)*deltaTime
		var value = (self.p*(goal-measurement)
			+ self.i*(self.totalError)
			+ self.d*((goal-measurement)-self.lastError)/(deltaTime+1e-6)
		)
		self.lastMeasurement = measurement
		self.lastError = goal-measurement
		return value

var pidControllerStageOne:PIDController = PIDController.new(kStageOneP, kStageOneI, kStageOneD)
var pidControllerStageTwo:PIDController = PIDController.new(kStageTwoP, kStageTwoI, kStageTwoD)

var goal:float = CONSTANTS.ELEVATOR_MIN_EXTENSION
var delta:float = 0

'''Sets the goal percent.'''
func setGoalPercent(percentage:float) -> void:
	setGoalPosition((CONSTANTS.ELEVATOR_MAX_EXTENSION - CONSTANTS.ELEVATOR_MIN_EXTENSION) * percentage)
	
'''Sets the goal position (as in, distance from min extension).'''
func setGoalPosition(pos:float) -> void:
	goal = pos

'''Process physics.'''
func do_physics(inDelta:float) -> void:
	delta = inDelta
	var fb = pidControllerStageOne.calculate(stageOne.global_position.y - CONSTANTS.ELEVATOR_MIN_EXTENSION, goal, delta)
	#print("goal is " + str(goal))
	#print("power is " + str(fb))
	#print("position is " + str(stageOne.global_position.y - CONSTANTS.ELEVATOR_MIN_EXTENSION))
	
	stageOne.transform = stageOne.transform.orthonormalized()
	stageOne.apply_central_force(Vector3(0, fb * delta, 0))
	
	fb = pidControllerStageTwo.calculate(stageTwo.global_position.y - stageOne.global_position.y, goal, delta)
	#print("goal is " + str(goal))
	#print("power is " + str(fb))
	#print("position is " + str(stageTwo.global_position.y - stageOne.global_position.y))
	stageTwo.transform = stageTwo.transform.orthonormalized()
	stageTwo.apply_central_force(Vector3(0, fb * delta, 0))
