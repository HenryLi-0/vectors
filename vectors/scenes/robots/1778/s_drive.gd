extends RigidBody3D

@onready var audio: AudioStreamPlayer2D = $Audio
var audioRNG:RandomNumberGenerator = RandomNumberGenerator.new()
var CONSTANTS = preload("res://scenes/robots/1778/constants.gd")

var force:Vector3
var delta:float = 0
# This is for stuff like auto align!
var automation:bool = false
var targetX:float = 0
var targetZ:float = 0
var targetO:float = 0

var pidX:PIDController = PIDController.new(0.007, 0.005, 0.08) # translate x
var pidZ:PIDController = PIDController.new(0.007, 0.005, 0.08) # translate z
var pidO:PIDController = PIDController.new(0.1, 0.03, 0.17) # rotate

'''Controls'''
var c_translation:Vector2 = Vector2(0,0)
var c_rotation:float = 0

func _process(delta: float) -> void:
	audio.volume_linear = sqrt(linear_velocity.x**2 + linear_velocity.y**2 + linear_velocity.z**2)/CONSTANTS.DRIVE_MAX_SPEED
	if not(audio.playing):
		#audio.stream = load("res://assets/audio/drive" + str(audioRNG.randi_range(1,3)) + ".wav")
		audio.play()
	

'''Process physics.'''
func do_physics(inDelta: float) -> void:
	delta = inDelta
	
	if not(automation):
		c_translation = Input.get_vector("drive_neg_x", "drive_pos_x", "drive_neg_y", "drive_pos_y")
		c_rotation = Input.get_axis("turn_neg", "turn_pos")
	else:
		c_translation = Vector2(pidZ.calculate(global_position.z, targetZ, delta), pidX.calculate(global_position.x, targetX, delta))
		if abs(global_rotation.y - targetO) > PI: # to fix wrapping leading to infinite spin
			targetO += 2 * PI if global_rotation.y > targetO else -2 * PI
		c_rotation = pidO.calculate(global_rotation.y, targetO, delta)
		#print(c_translation)
		#print("x: " + str(position.x) + " " + str(targetX))
		#print("z: " + str(position.z) + " " + str(targetZ))
		#print("(" + str(c_rotation) + ")")
		#print("o: " + str(rotation.y) + " " + str(targetO))
		print("distance error: " + str(sqrt((global_position.x-targetX)**2 + (global_position.z-targetZ)**2)))
		#print("rotation error (deg): " + str(abs(global_rotation_degrees.y-targetO)))
	
	if c_translation.length() > 1:
		c_translation = c_translation.normalized()
	if abs(c_rotation) > 1: c_rotation = sign(c_rotation)
	c_rotation = sign(c_rotation) * (c_rotation**2)
	
	force = Vector3((c_translation.y * CONSTANTS.DRIVE_FORCE + CONSTANTS.DRIVE_FORCE_ADD) * delta, 0, (c_translation.x * CONSTANTS.DRIVE_FORCE + CONSTANTS.DRIVE_FORCE_ADD) * delta)
	apply_force(force, Vector3(0.85, 0, 0.85))
	apply_force(force, Vector3(0.85, 0, -0.85))
	apply_force(force, Vector3(-0.85, 0, -0.85))
	apply_force(force, Vector3(-0.85, 0, 0.85))
	linear_velocity.x = clamp(linear_velocity.x, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	linear_velocity.y = clamp(linear_velocity.y, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)
	linear_velocity.z = clamp(linear_velocity.z, -CONSTANTS.DRIVE_MAX_SPEED, CONSTANTS.DRIVE_MAX_SPEED)

	force = Vector3((c_rotation * CONSTANTS.TURN_FORCE + CONSTANTS.TURN_FORCE_ADD) * delta, 0, 0)
	apply_force(force.rotated(Vector3.UP, 45), Vector3(0.85, 0, 0.85))
	apply_force(force.rotated(Vector3.UP, 135), Vector3(0.85, 0, -0.85))
	apply_force(force.rotated(Vector3.UP, 225), Vector3(-0.85, 0, -0.85))
	apply_force(force.rotated(Vector3.UP, 315), Vector3(-0.85, 0, 0.85))
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
