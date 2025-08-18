extends RigidBody3D

var CONSTANTS = preload("res://scenes/robots/1778/constants.gd")

var delta:float = 0
var automation:bool = false # This is for stuff like auto align!
var alignGoal:String = "" # Auto align goal

'''Controls'''
var c_translation:Vector2 = Vector2(0,0)
var c_rotation:float = 0

'''Process physics.'''
func do_physics(inDelta: float) -> void:
	delta = inDelta
	
	if not(automation):
		c_translation = Input.get_vector("drive_neg_x", "drive_pos_x", "drive_neg_y", "drive_pos_y").normalized()
		c_rotation = Input.get_axis("turn_neg", "turn_pos")
	else:
		pass
		
	apply_force(Vector3(c_translation.y * delta * CONSTANTS.DRIVE_FORCE, 0, c_translation.x * delta * CONSTANTS.DRIVE_FORCE))
	linear_velocity.x = clamp(linear_velocity.x, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	linear_velocity.y = clamp(linear_velocity.y, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	linear_velocity.z = clamp(linear_velocity.z, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	
	apply_torque(Vector3(0, c_rotation * CONSTANTS.TURN_FORCE, 0))
	angular_velocity.y = clamp(angular_velocity.y, -CONSTANTS.DRIVE_MAX_ROT, CONSTANTS.DRIVE_MAX_ROT)
	
	
	
