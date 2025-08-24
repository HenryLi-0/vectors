extends Node

'''DRIVETRAIN'''
# max speed/accel/rot not accurate yet
static var DRIVE_MAX_SPEED:float = 4 # m/s
static var DRIVE_MAX_ACCEL:float = 6 # m/s^2
static var DRIVE_MAX_ROT:float = 1.8 * PI # radians?
static var DRIVE_FORCE: float = 120000 # ???
static var TURN_FORCE: float = 800 # ???

'''ELEVATOR'''
static var ELEVATOR_MIN_EXTENSION:float = 0.02
static var ELEVATOR_MAX_EXTENSION:float = 0.92

'''SCORING'''
enum STATE {
	IDLE,		# Subsystems idle
	INTAKE,		# Intake extended, arm ready
	TRANSFER,	# Intake up, arm grabbing
	TRAVEL, 	# arm down, holding coral
	READY_C2,	# ready position L2 coral
	SCORE_C2,	# scoring L2 coral
	READY_C3,	# ready position L3 coral
	SCORE_C3,	# scoring L3 coral
	READY_C4,	# ready position L4 coral
	SCORE_C4,	# scoring L4 coral
	#GRAB_A2,	# grabbing L2 algae
	#GRAB_A3,	# grabbing L3 algae
	#BARGE,		# arm up, elevator up, barge
	#PROCESSOR,	# arm side, elevator down, processor
	}
'''
Reference
https://github.com/FIRST1778/2025-Robot-Code-Public/blob/main/src/main/java/org/chillout1778/subsystems/Elevator.kt#L23
'''
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
enum ARM_POSITIONS {
	# UNITS ARE IN DEGREES, CONVERT TO RADIANS + APPLY SHIFT!
	# degrees * PI/180
	L4ScoreCoral = 135,
	L4FinishScoreCoral = 100,
	AboveScoreCoral = 160,
	FinishScoreCoral = 105,	
}
static var SCORING_POSITIONS = {
	# ELEVATOR (INCHES), ARM (DEGREES)
	STATE.READY_C2 : [ELEVATOR_POSITIONS.L2Before	, ARM_POSITIONS.AboveScoreCoral		],
	STATE.SCORE_C2 : [ELEVATOR_POSITIONS.L2Score	, ARM_POSITIONS.FinishScoreCoral	],
	STATE.READY_C3 : [ELEVATOR_POSITIONS.L3Before	, ARM_POSITIONS.AboveScoreCoral		],
	STATE.SCORE_C3 : [ELEVATOR_POSITIONS.L3Score	, ARM_POSITIONS.FinishScoreCoral	],
	STATE.READY_C4 : [ELEVATOR_POSITIONS.L4Before	, ARM_POSITIONS.L4ScoreCoral		],
	STATE.SCORE_C4 : [ELEVATOR_POSITIONS.L4Score	, ARM_POSITIONS.L4FinishScoreCoral	],
}
