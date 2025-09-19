extends Object

'''A PIDController.'''
class_name PIDController

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
