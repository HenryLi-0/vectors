extends Area3D

'''The number of points a branch is worth!'''
@export var autoPoints:int = 0
@export var telePoints:int = 0
@export var debug:bool = false

@onready var audio: AudioStreamPlayer2D = $"../Audio"
var audioRNG:RandomNumberGenerator = RandomNumberGenerator.new()

var scored:bool = false
var scoredName:String = ""
var scoreAudio:bool = false
var coral = null

func _process(delta: float) -> void:
	if scored and not(scoreAudio):
		if coral in get_overlapping_bodies() and not(coral.isControlled):
			audio.stream = load("res://assets/audio/score" + str(audioRNG.randi_range(1,3)) + ".wav")
			audio.play()
			scoreAudio = true
		
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
			scoreAudio = false
			coral = null

func getCoral() -> bool:
	return scored

func getPoints() -> int:
	# TODO implement auto point bonus
	if scored:
		return telePoints
	return 0
