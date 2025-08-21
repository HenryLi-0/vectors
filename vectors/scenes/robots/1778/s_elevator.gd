extends RigidBody3D

var delta:float = 0

'''Process physics.'''
func do_physics(inDelta:float) -> void:
	delta = inDelta
