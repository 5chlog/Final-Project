extends Node2D


export(int) var selectable_count = 0
var selected_count = 0


func _ready():
	for switch in get_children():
		switch.get_node("InteractableArea").disable()
