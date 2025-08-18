extends RigidBody3D

@export var kP:float = 0
@export var kI:float = 0
@export var kD:float = 0

var delta:float = 0

'''Process physics.'''
func do_physics(inDelta: float) -> void:
	delta = inDelta

	# arm.apply_torque(arm.global_transform.basis * Vector3.BACK * delta * (0 - arm.rotation.z) * 1)
