extends Node

var CONSTANTS = preload("res://scenes/robots/1778/constants.gd")

@onready var red_score: Label3D = $"Red Score"
@onready var blue_score: Label3D = $"Blue Score"
@onready var timer: Label3D = $Timer
@onready var ds_text: Label3D = $"DS Text"
var ds_cache: Array = ["***Robot program startup complete***\n",
					   "***Vectors " + CONSTANTS.VERSION+"***\n"]
var ds_max: int = 5;

'''updates red score text'''
func updateRed(new:int) -> void:
	red_score.text = str(new)

'''updates blue score text'''
func updateBlue(new:int) -> void:
	blue_score.text = str(new)

'''timer'''
func updateTimer(new:int) -> void:
	timer.text = str(floor(new/60)) + ":" + (""  if (new%60 > 10) else "0") + str(new%60)

'''post ds text'''
func updateDS(new:String) -> void:
	ds_cache.append(str(new) + "\n")
	if len(ds_cache) > ds_max:
		ds_cache.remove_at(0) # larger index means newer message
	var temp:String
	for item in ds_cache:
		temp += item
	ds_text.text = temp
