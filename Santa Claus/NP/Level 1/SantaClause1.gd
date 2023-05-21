extends Sprite

# Dialogs
var first_dialog = preload("res://Santa Claus/NP/Level 1/Dialogs/FirstDialog.tres")
var puzzle_instr = preload("res://Santa Claus/NP/Level 1/Dialogs/PuzzleInstructions.tres")
var in_puzzle_dialog = preload("res://Santa Claus/NP/Level 1/Dialogs/InPuzzleDialog.tres")
var puzzle_yes_correct = preload("res://Santa Claus/NP/Level 1/Dialogs/PuzzleYesCorrect.tres")
var puzzle_yes_wrong = preload("res://Santa Claus/NP/Level 1/Dialogs/PuzzleYesWrong.tres")
var puzzle_yes_none = preload("res://Santa Claus/NP/Level 1/Dialogs/PuzzleYesNone.tres")
var puzzle_no_correct = preload("res://Santa Claus/NP/Level 1/Dialogs/PuzzleNoCorrect.tres")
var puzzle_no_wrong = preload("res://Santa Claus/NP/Level 1/Dialogs/PuzzleNoWrong.tres")
var puzzle_giveup = preload("res://Santa Claus/NP/Level 1/Dialogs/PuzzleGiveup.tres")
var puzzle_solved = preload("res://Santa Claus/NP/Level 1/Dialogs/PuzzleSolved.tres")
var to_verification = preload("res://Santa Claus/NP/Level 1/Dialogs/ToVerification.tres")


var complete: bool = false
var current_dialog = first_dialog
#Stores index values of each gift assigned to each child
var preset_certificate = [[3], [1, 2]]

onready var animation = $AnimationPlayer
export(Array, Resource) var dialogs

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")
	animation.play("Idle")
	#Certificates.clear_generator_data()


func interact():
	if current_dialog != null:
		$InteractableArea.disable()
		start_current_dialog()


func solved():
# check if every child have a happiness value above threshold
	var children = get_node("/root/HUD/ExtraHUD").get_children_node()
	
	for child in children.get_children():
		var gifts = child.get_node("Gifts").get_children()
		if gifts != null :
			if child.happiness < children.threshold:
				return false
	
	return true


func start_current_dialog():
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)


func start_level():
	get_node("../SendButton/InteractableArea").enable()
	get_node("../ReceiveButton/InteractableArea").enable()
	
	for slot in get_node("../GiftSlots").get_children():
		slot.get_node("InteractableArea").enable()
		
	get_node("../ChildDisplay/InteractableArea").enable()


func end_level():
	get_node("../SendButton/InteractableArea").disable()
	get_node("../ReceiveButton/InteractableArea").disable()
	
	for slot in get_node("../GiftSlots").get_children():
		slot.get_node("InteractableArea").disable()
		
	get_node("../ChildDisplay/InteractableArea").disable()
	# DialogBox.disconnect("dialogbox_closed", self, "_on_dialogbox_closed")


func set_certificate_from_level():
	var children = get_node("/root/HUD/ExtraHUD").get_children_node()
	var threshold = children.threshold
	Certificates.set_threshold(threshold)
	
	for child in children.get_children():
		var gifts = child.get_node("Gifts").get_children()
		if gifts != null :
			Certificates.add_gift_textures(gifts)
			Certificates.add_happiness_values(child.happiness)
		else:
			Certificates.add_gift_textures(null)
			Certificates.add_happiness_values(-1)
	print( )
	print(Certificates.gift_textures , "\n" , Certificates.happiness_values , "\n" , Certificates.threshold)


func set_certificate_from_preset():
	var children = get_node("/root/HUD/ExtraHUD").get_children_node()
	var gifts = get_node("../Gifts")
	preset_certificate.resize(children.get_child_count())
	Certificates.set_threshold(children.threshold)

	for i in preset_certificate.size() :
		var found = false
		var gift_list = []
		var happiness = 0
		for gift_i in preset_certificate[i] : 
			if gifts.get_children() != null :
				for gift in gifts.get_children() :
					if gift.gift_index == gift_i :
						gift_list.append(gift)
						happiness += gift.gift_values[i]
						found = true
			if found :
				continue
			for child in children.get_children() :
				var child_gifts = child.get_node("Gifts").get_children()
				if child_gifts != null :
					for gift in child_gifts :
						if gift.gift_index == gift_i :
							gift_list.append(gift)
							happiness += gift.gift_values[i]
							found = true
			if !found:
				print("You messed up the preset certificate")
		Certificates.add_gift_textures(gift_list)
		Certificates.add_happiness_values(happiness)
		
	print(Certificates.gift_textures , "\n" , Certificates.happiness_values , "\n" , Certificates.threshold)


# Yes reply to First Dialog
func first_dialog_yes():
	start_level()
	current_dialog = puzzle_instr
	start_current_dialog()


# No reply to First Dialog
func first_dialog_no():
	DialogBox.disable_dialog_box()


# Yes reply to In Puzzle Dialog
func in_puzzle_yes():
	if solved():
		current_dialog = puzzle_yes_correct
		if not (2 in ProgressData.santa_claus_levels_unlocked):
			ProgressData.santa_claus_levels_unlocked.append(2)
	
	elif not get_parent().has_solution:
		current_dialog = puzzle_yes_none
		ProgressData.level_lost_last[ProgressData.puzzle_types.SantaClausPuzzle] = 1
		if not (3 in ProgressData.lessons_unlocked):
			ProgressData.lessons_unlocked.append(3)
		if not (ProgressData.puzzle_types.SantaClausPuzzle in ProgressData.lesson_3_puzzles_unlocked):
			ProgressData.lesson_3_puzzles_unlocked.append(ProgressData.puzzle_types.SantaClausPuzzle)
		if not (1 in ProgressData.santa_claus_vf_levels_unlocked):
			ProgressData.santa_claus_vf_levels_unlocked.append(1)
	
	else:
		current_dialog = puzzle_yes_wrong
		ProgressData.level_lost_last[ProgressData.puzzle_types.SantaClausPuzzle] = 1
		if not (3 in ProgressData.lessons_unlocked):
			ProgressData.lessons_unlocked.append(3)
		if not (ProgressData.puzzle_types.SantaClausPuzzle in ProgressData.lesson_3_puzzles_unlocked):
			ProgressData.lesson_3_puzzles_unlocked.append(ProgressData.puzzle_types.SantaClausPuzzle)
		if not (1 in ProgressData.santa_claus_vf_levels_unlocked):
			ProgressData.santa_claus_vf_levels_unlocked.append(1)
	
	start_current_dialog()


# No reply to In Puzzle Dialog
func in_puzzle_no():
	if get_parent().has_solution:
		current_dialog = puzzle_no_wrong
		ProgressData.level_lost_last[ProgressData.puzzle_types.SantaClausPuzzle] = 1
		if not (3 in ProgressData.lessons_unlocked):
			ProgressData.lessons_unlocked.append(3)
		if not (ProgressData.puzzle_types.SantaClausPuzzle in ProgressData.lesson_3_puzzles_unlocked):
			ProgressData.lesson_3_puzzles_unlocked.append(ProgressData.puzzle_types.SantaClausPuzzle)
		if not (1 in ProgressData.santa_claus_vf_levels_unlocked):
			ProgressData.santa_claus_vf_levels_unlocked.append(1)
	
	else:
		current_dialog = puzzle_no_correct
		if not (2 in ProgressData.santa_claus_levels_unlocked):
			ProgressData.santa_claus_levels_unlocked.append(2)
		
	start_current_dialog()

# Give Up reply to In Puzzle Dialog
func in_puzzle_giveup():
	current_dialog = puzzle_giveup
	ProgressData.level_lost_last[ProgressData.puzzle_types.SantaClausPuzzle] = 1
	if not (3 in ProgressData.lessons_unlocked):
		ProgressData.lessons_unlocked.append(3)
	if not (ProgressData.puzzle_types.SantaClausPuzzle in ProgressData.lesson_3_puzzles_unlocked):
		ProgressData.lesson_3_puzzles_unlocked.append(ProgressData.puzzle_types.SantaClausPuzzle)
	if not (1 in ProgressData.santa_claus_vf_levels_unlocked):
		ProgressData.santa_claus_vf_levels_unlocked.append(1)
	
	start_current_dialog()

# Recheck reply to In Puzzle Dialog
func in_puzzle_recheck():
	DialogBox.disable_dialog_box()


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "Puzzle Instructions":
		current_dialog = in_puzzle_dialog
	elif dialog_name in ["Puzzle Yes Correct", "Puzzle No Correct"]:
		if get_node("/root/Level").final_level:
			if dialog_name == "Puzzle Yes Correct":
				set_certificate_from_level()
			else:
				set_certificate_from_preset()
			current_dialog = to_verification
			get_node("../DoorVerify").open_door()
		else:
			current_dialog = puzzle_solved
			get_node("../DoorOut").open_door()
		HUD.get_node("ExtraHUD").queue_free()
		end_level()
	elif dialog_name in ["Puzzle Yes None", "Puzzle Yes Wrong"]:
		set_certificate_from_level()
		HUD.get_node("ExtraHUD").queue_free()
		end_level()
		current_dialog = to_verification
		get_node("../DoorVerify").open_door()
	elif dialog_name in ["Puzzle No Wrong", "Puzzle Giveup"]:
		set_certificate_from_preset()
		HUD.get_node("ExtraHUD").queue_free()
		end_level()
		current_dialog = to_verification
		get_node("../DoorVerify").open_door()
		
	$InteractableArea.enable()

