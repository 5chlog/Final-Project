extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for room in get_node("Rooms").get_children():
		room.generator_1.room_list.append(room)
		room.generator_2.room_list.append(room)
