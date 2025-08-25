extends Node

'''DRIVETRAIN'''
# max speed/accel/rot not accurate yet
static var DRIVE_MAX_SPEED:float = 3 # m/s
static var DRIVE_MAX_ACCEL:float = 5 # m/s^2, not implemented yet
static var DRIVE_MAX_ROT:float = 1 * PI # radians?
static var DRIVE_FORCE: float = 120000 # ???
static var TURN_FORCE: float = 800 # ???

'''ELEVATOR'''
static var ELEVATOR_MIN_EXTENSION:float = 0.02
static var ELEVATOR_MAX_EXTENSION:float = 0.92

'''SCORING'''
enum STATE {
	IDLE,			# Subsystems idle
	INTAKE,			# Intake extended, arm ready
	LIFTINTAKE,		# Intake lifts up, nothing else changes
	PRETRANSFER,	# intake up, arm ready
	TRANSFER,		# Intake up, arm grabbing
	TRAVEL, 		# arm down, holding coral
	READY_C2,		# ready position L2 coral
	SCORE_C2,		# scoring L2 coral
	READY_C3,		# ready position L3 coral
	SCORE_C3,		# scoring L3 coral
	READY_C4,		# ready position L4 coral
	SCORE_C4,		# scoring L4 coral
	#GRAB_A2,		# grabbing L2 algae
	#GRAB_A3,		# grabbing L3 algae
	#BARGE,			# arm up, elevator up, barge
	#PROCESSOR,		# arm side, elevator down, processor
	}
'''
Reference
https://github.com/FIRST1778/2025-Robot-Code-Public/blob/main/src/main/java/org/chillout1778/subsystems/Elevator.kt#L23
'''
static var ELEVATOR_CONVERSION:float = 0.0254/2
enum ELEVATOR_POSITIONS {
	# UNITS ARE IN INCHES, CONVERT TO METERS!
	# inches * 0.0254
	PreTransfer = 36,
	Transfer = 33,
	L4Before = 55,
	L4Score = 54,
	L3Before = 31,
	L3Score = 28,	
	L2Before = 15,
	L2Score = 12,
}
'''
Reference:
https://github.com/FIRST1778/2025-Robot-Code-Public/blob/main/src/main/java/org/chillout1778/subsystems/Arm.kt#L42
'''
static var ARM_CONVERSION:float = PI/180
static var ARM_OFFSET:float = -PI
enum ARM_POSITIONS {
	# UNITS ARE IN DEGREES, CONVERT TO RADIANS + APPLY SHIFT!
	# degrees * PI/180
	# shift by -1/2 rotations
	Down = 0,
	L4ScoreCoral = 135,
	L4FinishScoreCoral = 100,
	AboveScoreCoral = 160,
	FinishScoreCoral = 105,	
}
static var STATE_POSITIONS = {
	# GROUND INTAKE RAISED?, GROUND ROLLER DIRECTION, ELEVATOR (INCHES), ARM (DEGREES), ARM ROLLERS DIRECTION
	STATE.IDLE			: ["idc",	 0,	"idc",							"idc",								 0	],
	STATE.INTAKE		: [false,	-1,	ELEVATOR_POSITIONS.PreTransfer,	ARM_POSITIONS.Down,					 0	],
	STATE.LIFTINTAKE	: [true,	-1, "idc", 							"idc",								 0	],
	STATE.PRETRANSFER	: [true,	 0,	ELEVATOR_POSITIONS.PreTransfer,	ARM_POSITIONS.Down,					 0	],
	STATE.TRANSFER		: [true,	 1,	ELEVATOR_POSITIONS.Transfer,	ARM_POSITIONS.Down,					-1	],
	STATE.TRAVEL		: [false,	 0,	ELEVATOR_POSITIONS.Transfer,	ARM_POSITIONS.Down,					 0	],
	STATE.READY_C2 		: [true,	 0,	ELEVATOR_POSITIONS.L2Before,	ARM_POSITIONS.AboveScoreCoral,		 0	],
	STATE.SCORE_C2 		: [true,	 0,	ELEVATOR_POSITIONS.L2Score,		ARM_POSITIONS.FinishScoreCoral,		 1	],
	STATE.READY_C3 		: [true,	 0,	ELEVATOR_POSITIONS.L3Before,	ARM_POSITIONS.AboveScoreCoral,		 0	],
	STATE.SCORE_C3 		: [true,	 0,	ELEVATOR_POSITIONS.L3Score,		ARM_POSITIONS.FinishScoreCoral,		 1	],
	STATE.READY_C4 		: [true,	 0,	ELEVATOR_POSITIONS.L4Before,	ARM_POSITIONS.L4ScoreCoral,			 0	],
	STATE.SCORE_C4 		: [true,	 0,	ELEVATOR_POSITIONS.L4Score,		ARM_POSITIONS.L4FinishScoreCoral,	 1	],
}
static var READY_SCORE_MAP = {
	STATE.READY_C2: STATE.SCORE_C2,
	STATE.READY_C3: STATE.SCORE_C3,
	STATE.READY_C4: STATE.SCORE_C4,
}
