extends Area3D

@export var detectorName:String = "Detector"

'''Detect when a coral enters.'''
func _on_body_entered(body: Node3D) -> void:
	print(detectorName + ":")
	
	if body is RigidBody3D:
		# future algae implementation!
		if body.name == "Coral" or body.name == "Algae":
			print("> get " + str(body.name))
			body.control(self)
	else:
		print("> something: " + str(body.name))
	

	
	
