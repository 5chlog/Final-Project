extends Node2D


enum partNames { GEAR, BATTERY, BOLT, SCREW, SPRING, FUEL, CAPACITOR, SWITCH, MOTOR, TRANSFORMER, 
		RESISTOR, BALLBEARING, LIGHT, KEY, DISPLAY, MICROCHIP}
var parts_used

onready var partsDictionary:Dictionary = {
	partNames.GEAR : 
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Gear.png")
		],
	partNames.BATTERY : 
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Battery.png")
		],
	partNames.BOLT : 
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Bolt.png")
		],
	partNames.SCREW : 
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Screw.png")
		],
	partNames.SPRING : 
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Spring.png")
		],
	partNames.FUEL : 
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Fuel.png")
		],
	partNames.CAPACITOR :
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Capacitor.png")
		],
	partNames.SWITCH :
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Switch.png")
		],
	partNames.MOTOR : 
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Motor.png")
		],
	partNames.TRANSFORMER : 
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Transformer.png")
		],
	partNames.RESISTOR :
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Resistor.png")
		],
	partNames.BALLBEARING :
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Ball_Bearings.png")
		],
	partNames.LIGHT :
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Light.png")
		],
	partNames.KEY :
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Key.png") 
		],
	partNames.DISPLAY :
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Display.png")
		],
	partNames.MICROCHIP :
		[
			0,
			preload("res://Mechanic Puzzle/NP/Sprites/parts/Microchip.png")
		]
}


func _ready():
	var n = get_child_count()
	parts_used = Certificates.parts_in_level
	if parts_used.size() > n:
		parts_used.resize(n)
	parts_used.sort()
	
	var i = 0 
	for part in parts_used:
		var cell = get_child(i)
		cell.get_child(0).texture = partsDictionary[part][1]
		i += 1
	for j in range(i, n):
		get_child(j).visible = false


# Activates cell for which parts are selected
func set_parts(var parts_selected: Array):
	clear_parts()
	for part in parts_selected:
		get_child(parts_used.find(part)).frame = 1


# Clears all selection
func clear_parts():
	for i in parts_used.size():
		get_child(i).frame = 0
