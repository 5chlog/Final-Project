extends Sprite


var complete: bool = false


# Dialogs
var first_dialog = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/FirstDialog.tres")
var puzzle_instr_1 = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleInstructions1.tres")
var puzzle_instr_2 = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleInstructions2.tres")
var in_puzzle_dialog = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/InPuzzleDialog.tres")
var puzzle_yes_correct = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleYesCorrect.tres")
var puzzle_yes_wrong = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleYesWrong.tres")
var puzzle_yes_none = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleYesNone.tres")
var puzzle_no_correct = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleNoCorrect.tres")
var puzzle_no_wrong = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleNoWrong.tres")
var puzzle_giveup = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleGiveup.tres")
var puzzle_solved = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/PuzzleSolved.tres")
var to_verification = preload("res://Buildng Powering Puzzle/NP/Test/Dialogs/ToVerification.tres")

var current_dialog = first_dialog
export(Array, int) var preset_certificate = [2, 3, 4, 5]


func _ready():
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")


func interact():
	if current_dialog != null:
		$InteractableArea.disable()
		start_current_dialog()


func solved():
	var rooms = get_node("../MapBorder/ViewportContainer/Viewport/Map/BuildingSprite/Graph/Rooms")
	for room in rooms.get_children():
		if not room.on:
			return false
	
	return true


func start_current_dialog():
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)


func start_level():
	for switch in get_node("../GeneratorSwitches").get_children():
		switch.get_node("InteractableArea").enable()
	get_node("../MapSwitch").interactactable_area.enable()


func end_level():
	for switch in get_node("../GeneratorSwitches").get_children():
		switch.get_node("InteractableArea").disable()
	get_node("../MapSwitch").interactactable_area.disable()


func set_certificate_from_level():
	var generators = get_node("../MapBorder/ViewportContainer/Viewport/Map/BuildingSprite/Graph/Generators")
	for generator in generators.get_children():
		if generator.on:
			Certificates.add_generator_data(generator.id_number)
	print(Certificates.generator_data)
	# Certificates.sort_generator_data()


func set_certificate_from_preset():
	preset_certificate.resize(get_node("../GeneratorSwitches").selectable_count)
	for data in preset_certificate:
		Certificates.add_generator_data(data)
	print(Certificates.generator_data)
	# Certificates.sort_generator_data()


# Yes reply to First Dialog
func first_dialog_yes():
	start_level()
	current_dialog = puzzle_instr_1
	start_current_dialog()


# No reply to First Dialog
func first_dialog_no():
	DialogBox.disable_dialog_box()


# Yes reply to In Puzzle Dialog
func in_puzzle_yes():
	if solved():
		current_dialog = puzzle_yes_correct
	elif not get_parent().has_solution:
		current_dialog = puzzle_yes_none
	else:
		current_dialog = puzzle_yes_wrong
	
	get_node("/root/HUD/ExtraHUD").hide_select_count()


# No reply to In Puzzle Dialog
func in_puzzle_no():
	if get_parent().has_solution:
		current_dialog = puzzle_no_wrong
	else:
		current_dialog = puzzle_no_correct
	
	get_node("/root/HUD/ExtraHUD").hide_select_count()


# Give Up reply to In Puzzle Dialog
func in_puzzle_giveup():
	current_dialog = puzzle_giveup
	get_node("/root/HUD/ExtraHUD").hide_select_count()


# Recheck reply to In Puzzle Dialog
func in_puzzle_recheck():
	DialogBox.disable_dialog_box()


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "Puzzle Instructions 1":
		$InteractableArea.player.toggleHold()
		current_dialog = puzzle_instr_2
		get_node("/root/HUD/ExtraHUD").show_select_count()
		return
	elif dialog_name == "Puzzle Instructions 2":
		current_dialog = in_puzzle_dialog
	elif dialog_name in ["Puzzle Yes Correct", "Puzzle No Correct"]:
		HUD.get_node("ExtraHUD").queue_free()
		end_level()
		if get_node("/root/Level").final_level:
			if dialog_name == "Puzzle Yes Correct":
				set_certificate_from_level()
			else:
				set_certificate_from_preset()
			get_node("../Door").open_door()
	elif dialog_name in ["Puzzle Yes None", "Puzzle Yes Wrong"]:
		HUD.get_node("ExtraHUD").queue_free()
		end_level()
		set_certificate_from_level()
		get_node("../Door").open_door()
	elif dialog_name in ["Puzzle No Wrong", "Puzzle Giveup"]:
		HUD.get_node("ExtraHUD").queue_free()
		end_level()
		set_certificate_from_preset()
		get_node("../Door").open_door()
		
	$InteractableArea.enable()


func _on_animation_finished(anim_name):
	if anim_name == "Show Select Count":
		start_current_dialog()
	elif anim_name == "Hide Select Count":
		start_current_dialog()
		if current_dialog in [puzzle_yes_correct, puzzle_no_correct]:
			current_dialog = puzzle_solved
		else:
			current_dialog = to_verification
