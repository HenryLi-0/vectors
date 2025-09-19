extends RigidBody3D

@export var kP:float = 5.2
@export var kI:float = 0
@export var kD:float = 0.12

var pidController:PIDController = PIDController.new(kP, kI, kD)
var goal:float = 0
var pos:float = 0

var delta:float = 0

'''Sets the arm position goal.'''
func setGoal(newGoal:float = 0) -> void:
	goal = newGoal

'''Process physics.'''
func do_physics(inDelta: float) -> void:
	delta = inDelta

	var fb = pidController.calculate(pos, goal, delta)
	#print("goal is " + str(goal))
	#print("power is " + str(fb))
	#print("position is " + str(pos))
	
	transform = transform.orthonormalized()
	#rotate_object_local(Vector3(0,0,1), fb * delta)
	rotation.z = pos
	pos += fb * delta
	#apply_torque(global_transform.basis.z * fb * delta)
