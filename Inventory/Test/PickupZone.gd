extends Area2D

func _ready():
	pass 
	
var in_range_items = {}


func _on_PickupZone_body_entered(body):
	in_range_items[body] = body


func _on_PickupZone_body_exited(body):
	if in_range_items.has(body):
		in_range_items.erase(body)
