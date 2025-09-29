extends RigidBody3D

@onready var stallAudio: AudioStreamPlayer2D = $StallAudio
@onready var intakeAudio: AudioStreamPlayer2D = $IntakeAudio
var audioRNG:RandomNumberGenerator = RandomNumberGenerator.new()

@export var kP:float = 5
@export var kI:float = 0
@export var kD:float = 0.7

@onready var detection: Area3D = $detection

var pidController:PIDController = PIDController.new(kP, kI, kD)
var goal:float = 0
var pos:float = 0

var delta:float = 0

'''Sets the ground intake position goal.'''
func setGoal(newGoal:float = 0) -> void:
	goal = newGoal
	
func _process(delta: float) -> void:
	'''intake noises'''
	intakeAudio.volume_linear = 1 if (pos > 0.5 and not(detection.controlling)) else 0
	if not(intakeAudio.playing):
		intakeAudio.stream = load("res://assets/audio/intake" + str(audioRNG.randi_range(1,3)) + ".wav")
		intakeAudio.play()
	'''stalling noises'''
	stallAudio.volume_linear = 1 if detection.controlling else 0
	if not(stallAudio.playing):
		stallAudio.stream = load("res://assets/audio/stall" + str(audioRNG.randi_range(1,3)) + ".wav")
		stallAudio.play()

'''Process physics.'''
func do_physics(inDelta:float) -> void:
	delta = inDelta
	if abs(rotation.x - pos) > PI/2:
		pos = rotation.x
	var fb = pidController.calculate(pos, goal, delta)
	#print("goal is " + str(goal))
	#print("power is " + str(fb))
	#print("position is " + str(pos))
	
	#transform = transform.orthonormalized()
	rotate_object_local(Vector3(1,0,0), fb * delta)
	pos += fb * delta
	pos = clamp(pos, -PI/2, 0.87)
	rotation.x = pos
	#apply_torque(global_transform.basis.x * fb * delta)
	
