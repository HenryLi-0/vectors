extends Area3D

'''The number of points a branch is worth!'''
@export var autoPoints:int = 0
@export var telePoints:int = 0
@export var debug:bool = false

@onready var audio: AudioStreamPlayer2D = $"../Audio"
var audioRNG:RandomNumberGenerator = RandomNumberGenerator.new()

var scored:bool = false
var scoredName:String = ""
var actuallyScored:bool = false # coral released/no longer controlled
var coral = null

func _process(delta: float) -> void:
	if scored and not(actuallyScored):
		if coral in get_overlapping_bodies() and not(coral.isControlled):
			audio.stream = load("res://assets/audio/score" + str(audioRNG.randi_range(1,3)) + ".wav")
			audio.play()
			actuallyScored = true
		
func _on_body_entered(body: Node3D) -> void:
	if debug: print(body.name + ": body entered")
	if body is RigidBody3D:
		if body.name.begins_with("Coral") and not(scored):
			if debug: print("   CORAL SCORED!")
			scored = true
			scoredName = body.name
			coral = body

func _on_body_exited(body: Node3D) -> void:
	if debug: print(body.name + ": body exited")
	if body is RigidBody3D:
		if body.name.begins_with("Coral") and scoredName == body.name:
			if debug: print("   CORAL LEFT!")
			scored = false
			actuallyScored = false
			coral = null

func getCoral() -> bool:
	return actuallyScored

func getPoints() -> int:
	# TODO implement auto point bonus
	if actuallyScored:
		return telePoints
	return 0
