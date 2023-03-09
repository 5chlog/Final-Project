extends Node

var item_data: Dictionary

# Parse and store JSON file data in a dictionary
func _ready():
	item_data = load_data("res://Inventory/Test/ItemData.json")
	
func load_data(path):
	var json_data
	var file_ptr = File.new()
	
	file_ptr.open(path,File.READ)
	json_data = JSON.parse(file_ptr.get_as_text())
	file_ptr.close()
	return json_data.result



