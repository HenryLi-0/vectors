extends Area3D

'''The number of points a branch is worth!'''
@export var points:int = 0

'''This class shouldn't do the point scoring, the coral should!'''
func _ready() -> void:
	name = "REEF_BRANCH"
