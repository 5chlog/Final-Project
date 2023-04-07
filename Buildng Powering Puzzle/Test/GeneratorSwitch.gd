tool

extends Sprite


export(int) var generator_number = -1
var generator: GeneratorVertex = null
onready var parent = get_parent()


func _ready():
	$FirstDigitSprite.frame = int(generator_number/10) % 10 
	$SecondDigitSprite.frame = generator_number % 10
	frame = 0


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
		parent.selected_count -= 1
		generator.switch_off()
		frame = 0
		var count_string = String(parent.selected_count) + "/" + String(parent.selectable_count)
		get_node("../../ExtraHUD/SelectCount/SelectCountLabel").text = count_string
	elif parent.selectable_count > parent.selected_count:
		parent.selected_count += 1
		generator.switch_on()
		frame = 1
		var count_string = String(parent.selected_count) + "/" + String(parent.selectable_count)
		get_node("../../ExtraHUD/SelectCount/SelectCountLabel").text = count_string
	
	$InteractableArea.player.toggleHold()
