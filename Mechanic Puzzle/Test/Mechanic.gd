extends Sprite

var first_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleStartDialog.tres")
var instructions_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleInstructions.tres")
var puzzle_complete_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleCompleteDialog.tres")

var puzzle_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/InPuzzleDialog.tres")
var puzzle_yes_correct_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleYesCorrectDialog.tres")
var puzzle_yes_none_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleYesNoneDialog.tres")
var puzzle_yes_wrong_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleYesWrongDialog.tres")
var puzzle_no_correct_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleNoCorrectDialog.tres")
var puzzle_no_wrong_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleNoWrongDialog.tres")
var puzzle_give_up_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleGiveUpDialog.tres")

var current_dialog = first_dialog
var started: bool = false


func _ready():
	get_node("../Extra HUD/AnimationPlayer").connect("animation_finished", self, 
			"_scanner_anim_completed")
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")


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


# Function called when replying Yes to Start Dialog
func start_dialog_yes_button_function():
	DialogBox.disable_dialog_box()
	$InteractableArea.player.toggleHold()
	current_dialog = instructions_dialog
	get_node("../Extra HUD").equip_scanner()


# Function called when replying No to Start Dialog
func start_dialog_no_button_function():
	DialogBox.disable_dialog_box()
	$InteractableArea.enable()


# Function called when replying Yes to In Puzzle Dialog
func in_puzzle_dialog_yes_function():
	var extra_hud = get_node("../Extra HUD")
	
	extra_hud.hide_select_count()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	extra_hud.unequip_scanner()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	
	if not get_parent().has_solution:
		DialogBox.enable_dialog_box(puzzle_yes_none_dialog, self, $InteractableArea.player)
	elif found_cover():
		DialogBox.enable_dialog_box(puzzle_yes_correct_dialog, self, $InteractableArea.player)
	else:
		DialogBox.enable_dialog_box(puzzle_yes_wrong_dialog, self, $InteractableArea.player)
	
	current_dialog = puzzle_complete_dialog


# Function called when replying No to In Puzzle Dialog
func in_puzzle_dialog_no_function():
	var extra_hud = get_node("../Extra HUD")
	
	extra_hud.hide_select_count()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	extra_hud.unequip_scanner()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	
	if get_parent().has_solution:
		DialogBox.enable_dialog_box(puzzle_no_wrong_dialog, self, $InteractableArea.player)
	else:
		DialogBox.enable_dialog_box(puzzle_no_correct_dialog, self, $InteractableArea.player)
	
	current_dialog = puzzle_complete_dialog


# Function called when replying Give Up to In Puzzle Dialog
func in_puzzle_dialog_giveup_function():
	var extra_hud = get_node("../Extra HUD")
	
	extra_hud.hide_select_count()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	extra_hud.unequip_scanner()
	yield(extra_hud.get_node("AnimationPlayer"), "animation_finished")
	
	DialogBox.enable_dialog_box(puzzle_give_up_dialog, self, $InteractableArea.player)
	
	current_dialog = puzzle_complete_dialog


# Function called when replying Recheck to In Puzzle Dialog
func in_puzzle_dialog_recheck_function():
	DialogBox.disable_dialog_box()


func _scanner_anim_completed(anim_name):
	if started:
		return
	
	if anim_name == "Slide Scanner In":
		get_node("../Extra HUD").show_select_count()
	
	
	elif anim_name == "Show Select Count":	
		DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)
		current_dialog = puzzle_dialog


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "Puzzle Instructions":
		var bottom_panel = get_node("../Conveyor").bottom_panel
		for child in bottom_panel.get_children():
			if child is MachineObject:
				child.get_node("InteractableArea").enable()
		get_node("../ConveyorSwitch/InteractableArea").enable()
		started = true
		$InteractableArea.enable()
	elif dialog_name in ["In Puzzle Dialog", "Puzzle Yes Correct Dialog", "Puzzle Yes Wrong Dialog",
			"Puzzle Yes None Dialog", "Puzzle No Correct Dialog", "Puzzle No Wrong Dialog",
			"Puzzle Give Up Dialog"]:
		$InteractableArea.enable()
