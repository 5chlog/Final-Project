extends Node2D


func _ready():
	if not (2 in ProgressData.mailbox_levels_unlocked):
		ProgressData.mailbox_levels_unlocked.append(2)
