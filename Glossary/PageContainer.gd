extends Control


var current_page = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for container in get_children():
		container.visible = false


func set_current_page(var container):
	current_page = container
