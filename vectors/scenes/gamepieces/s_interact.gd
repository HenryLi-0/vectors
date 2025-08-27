extends Area3D

@export var detectorName:String = "Detector"
@export var debug:bool = false

@export var constantSnap:bool = false
@export var alwaysSnapTo:Transform3D

var active:bool = false
var controlling:bool = false
var controlled:Node3D

'''Detect when a gamepiece enters and controls it.'''
func _on_body_entered(body: Node3D) -> void:
	if active:
		if debug: print(detectorName + ":")
		
		if body is RigidBody3D:
			# future algae implementation!
			if body.name.begins_with("Coral") or body.name.begins_with("Algae"):
				if debug: print("> get " + str(body.name))
				body.drop()
				controlled = body
				controlling = true
				body.control(self)
				if constantSnap:
					body.override(alwaysSnapTo)
			else:
				if debug: print("> something: " + str(body.name))
		else:
			if debug: print("> something: " + str(body.name))

'''Returns if the area is currently controlling something.'''
func isControlling() -> bool:
	if controlling:
		if not(controlled.controlledBy == self):
			controlling = false
	return controlling

'''Releases the controlled object.'''
func drop() -> void:
	if isControlling():
		controlled.drop()
		controlling = false
		if debug: print(detectorName + ": just dropped " + str(controlled.name))

func setActive(activated:bool) -> void:
	active = activated
