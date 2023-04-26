extends Node

# Vertex Cover Certificate data
var generator_data = []


func add_generator_data(id: int):
	generator_data.append(id)


func sort_generator_data():
	generator_data.sort()


func clear_generator_data():
	generator_data = []


# func _gen_data_compare(a, b):
# 	return a[0] < b[0]


# Set Cover Certificate data
