extends Node2D
class_name PartsDisplay

enum partNames { GEAR, BOLT, SCREW, BATTERY }
export(Array, partNames) var parts_used


onready var partsDictionary:Dictionary = {
	partNames.GEAR : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Gear.png")
		],
	partNames.BATTERY : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Battery.png")
		],
	partNames.BOLT : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Bolt.png")
		],
	partNames.SCREW : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
}


func _ready():
	pass
