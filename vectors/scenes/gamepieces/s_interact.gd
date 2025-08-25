extends Area3D

@export var detectorName:String = "Detector"

var controlling:bool = false
var controlled:Node3D

'''Detect when a gamepiece enters and controls it.'''
func _on_body_entered(body: Node3D) -> void:
	print(detectorName + ":")
	
	if body is RigidBody3D:
		# future algae implementation!
		if body.name == "Coral" or body.name == "Algae":
			print("> get " + str(body.name))
			controlled = body
			controlling = true
			body.control(self)
		else:
			print("> something: " + str(body.name))
	else:
		print("> something: " + str(body.name))

'''Returns if the area is currently controlling something.'''
func isControlling() -> bool:
	return controlling

'''Releases the controlled object.'''
func drop() -> void:
	if isControlling():
		controlled.drop()
		controlling = false
		print(detectorName + ": just dropped " + str(controlled.name))
