extends RigidBody3D

var CONSTANTS = preload("res://scenes/robots/1778/constants.gd")

var delta:float = 0
# This is for stuff like auto align!
var automation:bool = false
var targetX:float = 0
var targetZ:float = 0
var targetO:float = 0

var pidX:PIDController = PIDController.new(0.007, 0, 0.08) # translate x
var pidZ:PIDController = PIDController.new(0.007, 0, 0.08) # translate z
var pidO:PIDController = PIDController.new(0.007, 0, 0.08) # rotate

'''Controls'''
var c_translation:Vector2 = Vector2(0,0)
var c_rotation:float = 0

'''Process physics.'''
func do_physics(inDelta: float) -> void:
	delta = inDelta
	
	if not(automation):
		c_translation = Input.get_vector("drive_neg_x", "drive_pos_x", "drive_neg_y", "drive_pos_y")
		c_rotation = Input.get_axis("turn_neg", "turn_pos")
	else:
		c_translation = Vector2(pidZ.calculate(position.z, targetZ, delta), pidX.calculate(position.x, targetX, delta))
		c_rotation = pidO.calculate(rotation.y, targetO, delta)
		#print(c_translation)
		#print("x: " + str(position.x) + " " + str(targetX))
		#print("z: " + str(position.z) + " " + str(targetZ))
		#print("(" + str(c_rotation) + ")")
		#print("o: " + str(rotation.y) + " " + str(targetO))
		print("distance error: " + str(sqrt((position.x-targetX)**2 + (position.z-targetZ)**2)))
	
	if c_translation.length() > 1:
		c_translation = c_translation.normalized()
	if abs(c_rotation) > 1: c_rotation = sign(c_rotation)
	c_rotation = sign(c_rotation) * (c_rotation**2)
	
	apply_force(Vector3((c_translation.y * CONSTANTS.DRIVE_FORCE + CONSTANTS.DRIVE_FORCE_ADD) * delta,
						0,
						(c_translation.x * CONSTANTS.DRIVE_FORCE + CONSTANTS.DRIVE_FORCE_ADD) * delta))
	linear_velocity.x = clamp(linear_velocity.x, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	linear_velocity.y = clamp(linear_velocity.y, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	linear_velocity.z = clamp(linear_velocity.z, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)

	
	apply_torque(Vector3(0, c_rotation * CONSTANTS.TURN_FORCE * delta, 0))
	angular_velocity.y = clamp(angular_velocity.y, -CONSTANTS.DRIVE_MAX_ROT, CONSTANTS.DRIVE_MAX_ROT)
	
func setAuto(goalX:float, goalZ:float, goalO:float) -> void:
	targetX = goalX
	targetZ = goalZ
	targetO = goalO
	pidX.reset(position.x)
	pidZ.reset(position.z)
	pidO.reset(rotation.y)
	automation = true

func stopAuto() -> void:
	automation = false
