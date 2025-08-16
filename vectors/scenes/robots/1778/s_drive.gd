extends RigidBody3D

var CONSTANTS = preload("res://scenes/robots/1778/constants.gd")

func _init() -> void:
	pass

func _physics_process(delta: float) -> void:
	var translation:Vector2 = Input.get_vector("drive_neg_x", "drive_pos_x", "drive_neg_y", "drive_pos_y").normalized()
	apply_force(Vector3(translation.y * delta * CONSTANTS.DRIVE_FORCE, 0, translation.x * delta * CONSTANTS.DRIVE_FORCE))
	linear_velocity.x = clamp(linear_velocity.x, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	linear_velocity.y = clamp(linear_velocity.y, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	linear_velocity.z = clamp(linear_velocity.z, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	
	var rotation:float = Input.get_axis("turn_neg", "turn_pos")
	apply_torque(Vector3(0, rotation * CONSTANTS.TURN_FORCE, 0))
	angular_velocity.y = clamp(angular_velocity.y, -CONSTANTS.DRIVE_MAX_ROT, CONSTANTS.DRIVE_MAX_ROT)
	
	
