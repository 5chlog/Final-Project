extends Sprite


var started: bool = false

# Dialogs
var first_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleStartDialog.tres")
var instructions_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleInstructions.tres")
var puzzle_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/InPuzzleDialog.tres")
var puzzle_yes_correct_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleYesCorrectDialog.tres")
var puzzle_yes_none_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleYesNoneDialog.tres")
var puzzle_yes_wrong_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleYesWrongDialog.tres")
var puzzle_no_correct_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleNoCorrectDialog.tres")
var puzzle_no_wrong_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleNoWrongDialog.tres")
var puzzle_give_up_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleGiveUpDialog.tres")
var puzzle_solved_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/PuzzleSolvedDialog.tres")
var to_verify_dialog = preload("res://Mechanic Puzzle/NP/Test/Dialogs/ToVerificationDialog.tres")

var current_dialog = first_dialog
export(Array, Array, PartsDisplay.partNames) var preset_certificate = []


func _ready():
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")
	Certificates.clear_parts_list()


func interact():
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)
	$InteractableArea.disable()


# Function returns true if the selected objects form a cover; false otherwise
func found_cover():
	var display = get_node("../Display")
	
	for i in display.parts_used:
		if display.partsDictionary[i][0] == 0:
			return false
	return true


# Function that activates the puzzle elements in the scene
func start_level():
	var bottom_panel = get_node("../Conveyor").bottom_panel
	for child in bottom_panel.get_children():
		if child is MachineObject:
			child.get_node("InteractableArea").enable()
	get_node("../ConveyorSwitch/InteractableArea").enable()
	started = true


# Function that deactivates the puzzle elements in the scene
func end_level():
	HUD.get_node("Extra HUD").queue_free()
		
	var bottom_panel = get_node("../Conveyor").bottom_panel
	for child in bottom_panel.get_children():
		if child is MachineObject:
			child.get_node("InteractableArea").disable()
	get_node("../ConveyorSwitch/InteractableArea").disable()


# Function that sets the Certificate for Mechanic puzzle from the level
func set_certificate_from_level():
	var panels = get_node("../Conveyor/Panels")
	for panel in panels.get_children():
		for child in panel.get_children():
			if child is MachineObject and child.selected:
				Certificates.add_parts_list(child.parts)


# Function that sets the Certificate for Mechanic puzzle from the preset
func set_certificate_from_preset():
	Certificates.parts_list = preset_certificate


# Function called when replying Yes to Start Dialog
func start_dialog_yes_button_function():
	DialogBox.disable_dialog_box()
	$InteractableArea.player.toggleHold()
	current_dialog = instructions_dialog
	get_node("/root/HUD//Extra HUD").equip_scanner()


# Function called when replying No to Start Dialog
func start_dialog_no_button_function():
	DialogBox.disable_dialog_box()
	$InteractableArea.enable()


# Function called when replying Yes to In Puzzle Dialog
func in_puzzle_dialog_yes_function():
	var extra_hud = get_node("/root/HUD//Extra HUD")
	
	extra_hud.hide_select_count()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	extra_hud.unequip_scanner()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	
	if found_cover():
		DialogBox.enable_dialog_box(puzzle_yes_correct_dialog, self, $InteractableArea.player)
		if get_node("/root/Level").final_level:
			current_dialog = to_verify_dialog
		else:
			current_dialog = puzzle_solved_dialog
	elif not get_parent().has_solution:
		DialogBox.enable_dialog_box(puzzle_yes_none_dialog, self, $InteractableArea.player)
		current_dialog = to_verify_dialog
	else:
		DialogBox.enable_dialog_box(puzzle_yes_wrong_dialog, self, $InteractableArea.player)
		current_dialog = to_verify_dialog


# Function called when replying No to In Puzzle Dialog
func in_puzzle_dialog_no_function():
	var extra_hud = get_node("/root/HUD//Extra HUD")
	
	extra_hud.hide_select_count()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	extra_hud.unequip_scanner()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	
	if get_parent().has_solution:
		DialogBox.enable_dialog_box(puzzle_no_wrong_dialog, self, $InteractableArea.player)
		current_dialog = to_verify_dialog
	else:
		DialogBox.enable_dialog_box(puzzle_no_correct_dialog, self, $InteractableArea.player)
		if get_node("/root/Level").final_level:
			current_dialog = to_verify_dialog
		else:
			current_dialog = puzzle_solved_dialog


# Function called when replying Give Up to In Puzzle Dialog
func in_puzzle_dialog_giveup_function():
	var extra_hud = get_node("/root/HUD//Extra HUD")
	
	extra_hud.hide_select_count()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	extra_hud.unequip_scanner()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	
	DialogBox.enable_dialog_box(puzzle_give_up_dialog, self, $InteractableArea.player)
	
	current_dialog = to_verify_dialog


# Function called when replying Recheck to In Puzzle Dialog
func in_puzzle_dialog_recheck_function():
	DialogBox.disable_dialog_box()


func _scanner_anim_completed(anim_name):
	if started:
		return
	
	if anim_name == "Slide Scanner In":
		get_node("/root/HUD//Extra HUD").show_select_count()
	
	
	elif anim_name == "Show Select Count":	
		DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)
		current_dialog = puzzle_dialog


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "Puzzle Instructions":
		start_level()
		$InteractableArea.enable()
	elif dialog_name in ["Puzzle Yes Correct Dialog", "Puzzle No Correct Dialog"]:
		end_level()
		if get_node("/root/Level").final_level:
			if dialog_name == "Puzzle Yes Correct Dialog":
				set_certificate_from_level()
			else:
				set_certificate_from_preset()
			get_node("../Door").open_door()
		$InteractableArea.enable()
	elif dialog_name in ["Puzzle Yes Wrong Dialog", "Puzzle Yes None Dialog"]:
		end_level()
		set_certificate_from_level()
		get_node("../Door").open_door()
		$InteractableArea.enable()
	elif dialog_name in ["Puzzle No Wrong Dialog", "Puzzle Give Up Dialog"]:
		end_level()
		set_certificate_from_preset()
		get_node("../Door").open_door()
		$InteractableArea.enable()
	elif dialog_name in ["In Puzzle Dialog", "Puzzle Solved Dialog", "To Verification Dialog"]:
		$InteractableArea.enable()
