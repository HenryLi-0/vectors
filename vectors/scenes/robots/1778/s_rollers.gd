extends RigidBody3D

# Generic roller, basically a spinning something.

@export var inverted:bool = false
@export var lockPlaceX:bool = true
@export var lockPlaceY:bool = true
@export var lockPlaceZ:bool = true
@export var lockRotateX:bool = true
@export var lockRotateY:bool = true
@export var lockRotateZ:bool = true

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
	if lockPlaceX: position.x = initPosX
	if lockPlaceY: position.y = initPosY
	if lockPlaceZ: position.z = initPosZ
	#if lockRotateX: rotation.x = 0
	#if lockRotateY: rotation.y = 0
	#if lockRotateZ: rotation.z = 0
	if not(lockRotateX):
		apply_torque(global_transform.basis * Vector3.RIGHT * ((-1 if inverted else 1) * power * delta))
	elif not(lockRotateY):
		apply_torque(global_transform.basis * Vector3.UP * ((-1 if inverted else 1) * power * delta))
	elif not(lockRotateZ):
		apply_torque(global_transform.basis * Vector3.BACK * ((-1 if inverted else 1) * power * delta))
	else: pass
