extends Area3D

'''The number of points a branch is worth!'''
@export var autoPoints:int = 0
@export var telePoints:int = 0
@export var debug:bool = false

var scored:bool = false

func _ready() -> void:
	name = "REEF_BRANCH"

func _on_body_entered(body: Node3D) -> void:
	if debug: print(body.name + ": body entered")
	if body is RigidBody3D:
		if body.name.begins_with("Coral"):
			if debug: print("   CORAL SCORED!")
			scored = true

func _on_body_exited(body: Node3D) -> void:
	if debug: print(body.name + ": body exited")
	if body is RigidBody3D:
		if body.name.begins_with("Coral"):
			if debug: print("   CORAL SCORED!")
			scored = false

func getCoral() -> bool:
	return scored
