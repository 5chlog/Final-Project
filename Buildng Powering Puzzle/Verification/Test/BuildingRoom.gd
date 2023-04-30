tool
extends Sprite


export(int) var generator_1_no = -1
export(int) var generator_2_no = -1


func _ready():
	frame = 0


func interact():
	if generator_1_no == -1:
		print("Generator 1 Unassigned")
		return
	elif generator_2_no == -1:
		print("Generator 2 Unassigned")
		return
	
	if generator_1_no in Certificates.generator_data or generator_2_no in Certificates.generator_data:
		frame = 2
	else:
		frame = 1
	
	$InteractableArea.disable()
	$InteractableArea.player.toggleHold()
