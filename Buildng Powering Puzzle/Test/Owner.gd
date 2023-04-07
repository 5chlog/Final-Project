extends Sprite


var started: bool = false

# Dialogs
var first_dialog = preload("res://Buildng Powering Puzzle/Test/Dialogs/FirstDialog.tres")
var puzzle_instr = preload("res://Buildng Powering Puzzle/Test/Dialogs/PuzzleInstructions.tres")
var in_puzzle_dialog = preload("res://Buildng Powering Puzzle/Test/Dialogs/InPuzzleDialog.tres")
var puzzle_yes_correct = preload("res://Buildng Powering Puzzle/Test/Dialogs/PuzzleYesCorrect.tres")
var puzzle_yes_wrong = preload("res://Buildng Powering Puzzle/Test/Dialogs/PuzzleYesWrong.tres")
var puzzle_yes_none = preload("res://Buildng Powering Puzzle/Test/Dialogs/PuzzleYesNone.tres")
var puzzle_complete = preload("res://Buildng Powering Puzzle/Test/Dialogs/PuzzleComplete.tres")
var puzzle_no_correct = preload("res://Buildng Powering Puzzle/Test/Dialogs/PuzzleNoCorrect.tres")
var puzzle_no_wrong = preload("res://Buildng Powering Puzzle/Test/Dialogs/PuzzleNoWrong.tres")
var puzzle_giveup = preload("res://Buildng Powering Puzzle/Test/Dialogs/PuzzleGiveup.tres")

var current_dialog = first_dialog


func _ready():
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")


func interact():
	if current_dialog != null:
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
	if not started:
		for switch in get_node("../GeneratorSwitches").get_children():
			switch.get_node("InteractableArea").enable()
		get_node("../MapSwitch").interactactable_area.enable()


# Yes reply to First Dialog
func first_dialog_yes():
	start_level()
	started = true
	current_dialog = puzzle_instr
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
	
	start_current_dialog()
	current_dialog = puzzle_complete


# No reply to In Puzzle Dialog
func in_puzzle_no():
	if get_parent().has_solution:
		current_dialog = puzzle_no_wrong
	else:
		current_dialog = puzzle_no_correct
	
	start_current_dialog()
	current_dialog = puzzle_complete


# Give Up reply to In Puzzle Dialog
func in_puzzle_giveup():
	current_dialog = puzzle_giveup
	start_current_dialog()
	current_dialog = puzzle_complete


# Recheck reply to In Puzzle Dialog
func in_puzzle_recheck():
	DialogBox.disable_dialog_box()


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "Puzzle Instructions":
		current_dialog = in_puzzle_dialog
