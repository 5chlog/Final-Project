extends Sprite

var solution_index_mailbox:int = -1
onready var mailboxes: Mailboxes = get_parent().get_node("Mailboxes")

export(Array, Resource) var dialog_resource

# Dialogs
var puzzle_start = preload("res://Mailbox Puzzle/Level 3/Dialogs/Puzzle Start.tres")
var puzzle_intro = preload("res://Mailbox Puzzle/Level 3/Dialogs/Puzzle Introduction.tres")
var in_puzzle = preload("res://Mailbox Puzzle/Level 3/Dialogs/In Puzzle.tres")
var puzzle_yes_correct = preload("res://Mailbox Puzzle/Level 3/Dialogs/Puzzle Yes Correct.tres")
var puzzle_yes_wrong = preload("res://Mailbox Puzzle/Level 3/Dialogs/Puzzle Yes Wrong.tres")
var puzzle_no_correct = preload("res://Mailbox Puzzle/Level 3/Dialogs/Puzzle No Correct.tres")
var puzzle_no_wrong = preload("res://Mailbox Puzzle/Level 3/Dialogs/Puzzle No Wrong.tres")
var puzzle_success = preload("res://Mailbox Puzzle/Level 3/Dialogs/Puzzle Success.tres")
var puzzle_failure = preload("res://Mailbox Puzzle/Level 3/Dialogs/Puzzle Failure.tres")

var current_dialog = puzzle_start


func _ready():
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")
	for i in mailboxes.get_child_count():
		if mailboxes.get_child(i).target_mail_slot in [1, 2, 3]:
			solution_index_mailbox = i


func interact():
	$InteractableArea.disable()
	start_dialog()


func start_dialog():
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)


func start_puzzle():
	for mailbox in mailboxes.get_children():
		mailbox.active = true
		mailbox.get_node("InteractableArea").enable()


func end_puzzle():
	for mailbox in mailboxes.get_children():
		mailbox.active = false
		mailbox.get_node("InteractableArea").disable()


func start_yeah_button():
	current_dialog = puzzle_intro
	start_puzzle()
	start_dialog()


func start_no_button():
	DialogBox.disable_dialog_box()


func puzzle_yes_button():
	if mailboxes.selected_mailbox == solution_index_mailbox:
		if solution_index_mailbox != -1:
			current_dialog = puzzle_yes_correct
		else:
			current_dialog = puzzle_no_correct
		get_node("../DoorOut").open_door()
		
		if not (2 in ProgressData.lessons_unlocked):
			ProgressData.lessons_unlocked.append(2)
			ProgressData.lesson_2_puzzles_unlocked = [
				ProgressData.puzzle_types.BuildingPoweringPuzzle,
				ProgressData.puzzle_types.MechanicPuzzle,
				ProgressData.puzzle_types.SantaClausPuzzle,
			]
			ProgressData.building_powering_levels_unlocked.append(1)
			ProgressData.mechanic_levels_unlocked.append(1)
			ProgressData.santa_claus_levels_unlocked.append(1)
	else:
		if mailboxes.selected_mailbox != -1:
			current_dialog = puzzle_yes_wrong
		else:
			current_dialog = puzzle_no_wrong
		get_node("../DoorIn").open_door()
	
	end_puzzle()
	start_dialog()


func puzzle_continue_button():
	DialogBox.disable_dialog_box()


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "Puzzle Introduction":
		current_dialog = in_puzzle
	elif dialog_name in ["Puzzle Yes Correct", "Puzzle No Correct"]:
		current_dialog = puzzle_success
	elif dialog_name in  ["Puzzle Yes Wrong", "Puzzle No Wrong"]:
		current_dialog = puzzle_failure
	
	$InteractableArea.enable()
