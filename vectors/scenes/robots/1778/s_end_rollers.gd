extends RigidBody3D

@export var inverted:bool = false

var power:float = 0
var delta:float = 0

'''Sets the power to do at the next physics run.'''
func setPower(newPower:float = 1) -> void:
	power = newPower

'''Process physics.'''
func do_physics(inDelta:float) -> void:
	delta = inDelta
	apply_torque(global_transform.basis * Vector3.RIGHT * (-1 if inverted else 1) * power * delta)
