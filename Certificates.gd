extends Node

# Vertex Cover Certificate data
var generator_data = []


func add_generator_data(id: int):
	generator_data.append(id)


func sort_generator_data():
	generator_data.sort()


# func _gen_data_compare(a, b):
# 	return a[0] < b[0]


# Set Cover Certificate data
# List of Arrays having elements from PartsDisplay.partNames
var parts_list = []
var parts_in_level = []

func add_parts_list(list: Array):
	parts_list.append(list)


func clear_parts_list():
	parts_list = []


func clear_parts_in_level():
	parts_in_level = []
	
