extends RigidBody3D

const SPEED = 0.7
const FRICTION = 0.9 # more like non-friction
const STUCK_TOLERANCE = 0.001
var vx:float = 0.0
var vz:float = 0.0
var vo:float = 0.0

var lastx:float = 0.0
var lastz:float = 0.0

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("drive_neg_x", "drive_pos_x", "drive_neg_y", "drive_pos_y")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		vx += direction.x * SPEED * delta
		vz += direction.z * SPEED * delta
	else:
		vx += -direction.x * SPEED * delta
		vz += -direction.z * SPEED * delta

	vo += SPEED * Input.get_axis("turn_neg", "turn_pos")

	vx = clamp(vx * FRICTION, -10, 10)
	vz = clamp(vz * FRICTION, -10, 10)
	vo = clamp(vo * FRICTION, -0.1, 0.1)
	
	rotation.y += vo
	move_and_collide(Vector3(vx, 0, vz))
	
	if abs(lastx - position.x) < STUCK_TOLERANCE:
		vx = 0
	if abs(lastz - position.z) < STUCK_TOLERANCE:
		vz = 0
	lastx = position.x
	lastz = position.z
	
