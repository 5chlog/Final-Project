extends Node

# Vertex Cover Certificate data
var generator_data = []


func add_generator_data(id: int, powered: bool):
	generator_data.append([id, powered])


func sort_generator_data():
	generator_data.sort_custom(self, "_gen_data_compare")


func _gen_data_compare(a, b):
	return a[0] < b[0]


# Set Cover Certificate data
