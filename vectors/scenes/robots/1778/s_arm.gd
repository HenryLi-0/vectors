extends RigidBody3D

@export var kP:float = 5.2
@export var kI:float = 0
@export var kD:float = 0.12

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

var pidController:PIDController = PIDController.new(kP, kI, kD)
var goal:float = 0

var delta:float = 0

'''Sets the arm position goal.'''
func setGoal(newGoal:float = 0) -> void:
	goal = newGoal

'''Process physics.'''
func do_physics(inDelta: float) -> void:
	delta = inDelta
	var fb = pidController.calculate(rotation.z, goal, delta)
	#print("goal is " + str(goalrotation.z))
	
	transform = transform.orthonormalized()
	rotate_object_local(Vector3(0,0,1), fb * delta)
	#apply_torque(global_transform.basis.z * fb * delta)
	rotation.x = 0
	rotation.y = 0
