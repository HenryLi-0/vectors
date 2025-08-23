extends Area3D

@export var detectorName:String = "Detector"

'''Detect when a coral enters.'''
func _on_body_entered(body: Node3D) -> void:
	print(detectorName + ":")
	
	if body is RigidBody3D:
		if body.name == "Coral":
			print("> get coral")
		# future algae implementation!
		elif body.name == "Algae":
			print("> get algae")
		body.control(self)
	else:
		print("> something: " + str(body.name))
	

	
	
