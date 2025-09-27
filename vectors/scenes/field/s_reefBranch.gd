extends StaticBody3D

@export var debug:bool = false

@onready var l4: Area3D = $"L4 Area"
@onready var l3: Area3D = $"L3 Area"
@onready var l2: Area3D = $"L2 Area"

func getPoints() -> int:
	if not(l4 == null or l3 == null or l2 == null):
		return l4.getPoints() + l3.getPoints() + l2.getPoints()
	else:
		push_warning(self.name + ": some scoring areas are not detected")
		return 0
