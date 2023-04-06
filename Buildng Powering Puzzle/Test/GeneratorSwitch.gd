tool

extends Sprite


export(int) var generator_number = -1
var generator: GeneratorVertex = null


func _ready():
	$FirstDigitSprite.frame = int(generator_number/10) % 10 
	$SecondDigitSprite.frame = generator_number % 10


func interact():
	if generator_number == -1:
		print("Generator Unassigned")
		return
	
	if generator == null:
		var generators = get_node("../../MapBorder/ViewportContainer/Viewport/Map/BuildingSprite/Graph/Generators")
		for gen in generators.get_children():
			if gen.id_number == generator_number:
				generator = gen
				break
		# If generator with given ID is not found
		if generator == null:
			print("Generator Misassigned")
			return
	
	if generator.on:
		generator.switch_off()
		frame = 0
	else:
		generator.switch_on()
		frame = 1
	
	$InteractableArea.player.toggleHold()
