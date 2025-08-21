extends RigidBody3D

# Generic roller, basically a spinning something.

@export var inverted:bool = false
@export var rotateX:bool = false
@export var rotateY:bool = false
@export var rotateZ:bool = false

var initPosX:float
var initPosY:float
var initPosZ:float

var power:float = 0
var delta:float = 0

func _ready() -> void:
	initPosX = position.x
	initPosY = position.y
	initPosZ = position.z

'''Sets the power.'''
func setPower(newPower:float = 1) -> void:
	power = newPower

'''Process physics.'''
func do_physics(inDelta:float) -> void:
	delta = inDelta

	transform = transform.orthonormalized()
	if rotateX: 
		apply_torque(global_transform.basis.x * ((-1 if inverted else 1) * power))
		#rotate_object_local(Vector3.RIGHT, (-1 if inverted else 1) * power * delta)
	elif rotateY: 
		apply_torque(global_transform.basis.y * ((-1 if inverted else 1) * power))
		#rotate_object_local(Vector3.UP, (-1 if inverted else 1) * power * delta)
	elif rotateZ: 
		apply_torque(global_transform.basis.z * ((-1 if inverted else 1) * power))
		#rotate_object_local(Vector3.BACK, (-1 if inverted else 1) * power * delta)
	else: pass
	
	angular_velocity *= 0.7
