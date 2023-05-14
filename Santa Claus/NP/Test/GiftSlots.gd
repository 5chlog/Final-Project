extends Node2D

func get_free_slot():
	for slot in get_children():
		if slot.placed_gift == null :
			return slot
