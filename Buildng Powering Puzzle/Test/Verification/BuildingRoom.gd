tool
extends Sprite


export(int) var generator_1_no = -1
export(int) var generator_2_no = -1


func _ready():
	$"Generator 1 Indicator/Generator First Digit".frame = int(generator_1_no/10) % 10 
	$"Generator 1 Indicator/Generator Second Digit".frame = generator_1_no % 10
	$"Generator 2 Indicator/Generator First Digit".frame = int(generator_2_no/10) % 10 
	$"Generator 2 Indicator/Generator Second Digit".frame = generator_2_no % 10
	frame = 0


func interact():
	if generator_1_no == -1:
		print("Generator 1 Unassigned")
		return
	elif generator_2_no == -1:
		print("Generator 2 Unassigned")
		return
	
	if generator_1_no in Certificates.generator_data:
		$"Generator 1 Indicator/Indicator".frame = 1
	else:
		$"Generator 1 Indicator/Indicator".frame = 2
		
	if generator_2_no in Certificates.generator_data:
		$"Generator 2 Indicator/Indicator".frame = 1
	else:
		$"Generator 2 Indicator/Indicator".frame = 2
	
	print("Interacted")
	$InteractableArea.disable()
	$InteractableArea.player.toggleHold()
