extends Sprite


export(int) var generator_number = -1
var generator: GeneratorVertex = null


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
	
	if generator.on:
		generator.switch_off()
		frame = 0
	else:
		generator.switch_on()
		frame = 2
	
	$InteractableArea.player.toggleHold()
