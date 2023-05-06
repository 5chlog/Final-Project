extends Node2D


export(int) var threshold = 0

func _ready():
	for child in get_children():
		child.threshold = threshold
