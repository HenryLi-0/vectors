extends Node

'''RELEASE'''
static var VERSION:String = "v0.1"

'''DRIVETRAIN'''
# max speed/accel/rot not accurate yet
static var DRIVE_MAX_SPEED:float = 2 # m/s
static var DRIVE_MAX_ACCEL:float = 5 # m/s^2, not implemented yet
static var DRIVE_MAX_ROT:float = 0.5 * PI # radians?
static var DRIVE_FORCE: float = 40000 # ???
static var DRIVE_FORCE_ADD: float = 3000 # ???
static var TURN_FORCE: float = 25000 # ???
static var TURN_FORCE_ADD: float = 1000 # ???

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
Reference:
https://github.com/FIRST1778/2025-Robot-Code-Public/blob/main/src/main/java/org/chillout1778/subsystems/Elevator.kt#L23
'''
static var ELEVATOR_CONVERSION:float = 0.0254/2
enum ELEVATOR_POSITIONS {
	# UNITS ARE IN INCHES, CONVERT TO METERS!
	# inches * 0.0254
	PreTransfer = 42,
	Transfer = 33,
	L4Before = 56,
	L4Score = 53,
	L3Before = 38,
	L3Score = 34,
	L2Before = 21,
	L2Score = 17,
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
	L4ScoreCoral = 116,
	L4FinishScoreCoral = 108,
	AboveScoreCoral = 117,
	FinishScoreCoral = 107,	
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

'''
Reference:
https://github.com/wpilibsuite/allwpilib/blob/main/apriltag/src/main/native/resources/edu/wpi/first/apriltag/2025-reefscape-welded.csv
https://firstfrc.blob.core.windows.net/frc2025/FieldAssets/Apriltag_Images_and_User_Guide.pdf
'''
static var REEF_TAG_R_OFFSET = 0
static var REEF_TAG_X_OFFSET = 345.44
static var REEF_TAG_Z_OFFSET = 158
static var REEF_TAG_SCALE = 1*2.54/100
static var REEF_TAGS = [
	# ID,X,Z,Y,Z-Rotation,X-Rotation
	#[1,657.37,25.8,58.5,126,0],
	#[2,657.37,291.2,58.5,234,0],
	#[3,455.15,317.15,51.25,270,0],
	#[4,365.2,241.64,73.54,0,30],
	#[5,365.2,75.39,73.54,0,30],
	[6,530.49,130.17,12.13,300,0],
	[7,546.87,158.5,12.13,0,0],
	[8,530.49,186.83,12.13,60,0],
	[9,497.77,186.83,12.13,120,0],
	[10,481.39,158.5,12.13,180,0],
	[11,497.77,130.17,12.13,240,0],
	#[12,33.51,25.8,58.5,54,0],
	#[13,33.51,291.2,58.5,306,0],
	#[14,325.68,241.64,73.54,180,30],
	#[15,325.68,75.39,73.54,180,30],
	#[16,235.73,-0.15,51.25,90,0],
	[17,160.39,130.17,12.13,240,0],
	[18,144,158.5,12.13,180,0],
	[19,160.39,186.83,12.13,120,0],
	[20,193.1,186.83,12.13,60,0],
	[21,209.49,158.5,12.13,0,0],
	[22,193.1,130.17,12.13,300,0],
]
