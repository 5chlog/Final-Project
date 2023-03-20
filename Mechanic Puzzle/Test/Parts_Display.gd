extends Node2D
class_name PartsDisplay

enum partNames { GEAR, BOLT, SCREW, BATTERY, MOTOR, BLADES, FUEL, METAL}
export(Array, partNames) var parts_used


onready var partsDictionary:Dictionary = {
	partNames.GEAR : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Gear.png")
		],
	partNames.BATTERY : 
		[
			true,
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
	partNames.MOTOR : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.BLADES : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.FUEL : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.METAL : 
		[
			false,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
}


func _ready():
	var i:int = 0 
	var n:int = get_child_count()
	
	checker()
	
	for part in parts_used:
		if i<n:
			var child = get_child(i)
			print(child.get_child(0))
			child.get_child(0).texture = partsDictionary[part][1]
			i+=1
	pass
	
func checker():
	var i:int = 0 
	var n:int = get_child_count()
	
	for part in parts_used:
		if i<n:
			if partsDictionary[part][0]:
				get_child(i).frame = 1
			i+=1
		
	pass
