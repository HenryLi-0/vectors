extends Node3D

# Defines who is being controlled (in this case, the gamepieces!)
@export var subject:RigidBody3D

var isControlled:bool = false
var controlledBy:Node3D
var relativeTransform:Transform3D

func _physics_process(delta: float) -> void:
	if isControlled:
		subject.global_transform = controlledBy.global_transform * relativeTransform
		

'''getControlled() lol'''
func control(object:Node3D):
	print("controlled by: " + str(object.detectorName))
	isControlled = true
	controlledBy = object
	relativeTransform = object.global_transform.affine_inverse() * subject.global_transform
	
	subject.gravity_scale = 0
	subject.linear_velocity = Vector3.ZERO
	subject.angular_velocity = Vector3.ZERO

'''Drops the object from control'''
func drop():
	isControlled = false
	subject.gravity_scale = 1
