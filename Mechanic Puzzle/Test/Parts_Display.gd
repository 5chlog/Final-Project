extends Node2D
class_name PartsDisplay


enum partNames { GEAR, BATTERY, BOLT, SCREW, MOTOR, SPRING, FUEL, TRANSFORMER, CAPACITOR, RESISTOR, 
		SWITCH, BALLBEARING, LIGHT, TENSILECABLE, PISTON, TNUT}
export(Array, partNames) var parts_used

onready var partsDictionary:Dictionary = {
	partNames.GEAR : 
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Gear.png")
		],
	partNames.BATTERY : 
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Battery.png")
		],
	partNames.BOLT : 
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Bolt.png")
		],
	partNames.SCREW : 
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.SPRING : 
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Spring.png")
		],
	partNames.FUEL : 
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Fuel.png")
		],
	partNames.CAPACITOR :
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Capacitor.png")
		],
	partNames.SWITCH :
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Switch.png")
		],
	partNames.MOTOR : 
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.TRANSFORMER : 
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.RESISTOR :
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],	partNames.BALLBEARING :
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.LIGHT :
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.TENSILECABLE :
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png") 
		],
	partNames.PISTON :
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		],
	partNames.TNUT :
		[
			0,
			preload("res://Mechanic Puzzle/Test/Sprites/parts/Screw.png")
		]
}


func _ready():
	var n = get_child_count()
	if parts_used.size() > n:
		parts_used.resize(n)
	
	var i = 0 
	for part in parts_used:
		var cell = get_child(i)
		# print(cell.get_child(0))
		cell.get_child(0).texture = partsDictionary[part][1]
		i += 1


func add_parts(var parts_selected: Array):
	for part in parts_selected:
		if partsDictionary[part][0] == 0:
			get_child(parts_used.find(part)).frame = 1
		partsDictionary[part][0] += 1


func remove_parts(var parts_selected: Array):
	for part in parts_selected:
		if partsDictionary[part][0] == 1:
			get_child(parts_used.find(part)).frame = 0
		partsDictionary[part][0] -= 1
