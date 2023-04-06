tool

extends Sprite
class_name RoomEdge


const CONN_ON_COLOR = Color(1, 0.9, 0)
const CONN_OFF_COLOR = Color(0.808, 0.75, 0)


var on: bool = false

export(NodePath) var generator_1_path = null
export(NodePath) var generator_2_path = null
export(Vector2) var connection_1_anchor = Vector2.ZERO
export(Vector2) var connection_2_anchor = Vector2.ZERO

onready var generator_1: GeneratorVertex = get_node(generator_1_path)
onready var generator_2: GeneratorVertex = get_node(generator_2_path)
onready var connection_1: Line2D = get_node("Connection 1")
onready var connection_2: Line2D = get_node("Connection 2")


# Called when the node enters the scene tree for the first time.
func _ready():
	frame = 0
	
	# Setting default connection line parameters
	connection_1.default_color = CONN_OFF_COLOR
	connection_2.default_color = CONN_OFF_COLOR
	connection_1.width = 1
	connection_2.width = 1
	
	# Setting coordinates of room and generator for room end-point of lines
	var room_centre = Vector2(12, 20)
	var gen_centre = (generator_1.frames.get_frame("Off", 0).get_size() - Vector2(1, 1)) / 2
	gen_centre = Vector2(int(gen_centre.x), int(gen_centre.y))
	
	# Adding starting and anchor points
	connection_1.add_point(room_centre)
	connection_1.add_point(room_centre + connection_1_anchor)
	
	connection_2.add_point(room_centre)
	connection_2.add_point(room_centre + connection_2_anchor)
	
	# Setting coordinates for generator end-points and adding those points
	var room_pos_from_graph = position + get_parent().position
	
	var gen_pos_from_graph = generator_1.position + generator_1.get_parent().position
	var gen_pos_from_room = gen_pos_from_graph - room_pos_from_graph
	
	connection_1.add_point(gen_pos_from_room + gen_centre)
	
	gen_pos_from_graph = generator_2.position + generator_2.get_parent().position
	gen_pos_from_room = gen_pos_from_graph - room_pos_from_graph
	
	connection_2.add_point(gen_pos_from_room + gen_centre)


func switch_on(var calling_generator: GeneratorVertex):
	if calling_generator == generator_1:
		connection_1.default_color = CONN_ON_COLOR
	elif calling_generator == generator_2:
		connection_2.default_color = CONN_ON_COLOR
	
	if on:
		return
	
	frame = 1
	on = true


func switch_off(var calling_generator: GeneratorVertex):
	if calling_generator == generator_1:
		connection_1.default_color = CONN_OFF_COLOR
	elif calling_generator == generator_2:
		connection_2.default_color = CONN_OFF_COLOR
	
	if generator_1.on or generator_2.on:
		return
	
	frame = 0
	on = false
