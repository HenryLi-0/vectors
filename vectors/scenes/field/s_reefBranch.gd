extends Area3D

'''The number of points a branch is worth!'''
@export var autoPoints:int = 0
@export var telePoints:int = 0

func _ready() -> void:
	name = "REEF_BRANCH"

func _on_body_entered(body: Node3D) -> void:
	print(body.name + ": found something")
	if body is RigidBody3D:
		if body.name.begins_with("Coral"):
			print("CORAL SCORED!")
