extends Sprite


var complete: bool = false


# Dialogs
var first_dialog = preload("res://Buildng Powering Puzzle/Verification/Level 2/Dialogs/FirstDialog.tres")
var in_puzzle_dialog = preload("res://Buildng Powering Puzzle/Verification/Level 2/Dialogs/InPuzzleDialog.tres")
var verified_yes = preload("res://Buildng Powering Puzzle/Verification/Level 2/Dialogs/PuzzleVerifiedYes.tres")
var verified_no = preload("res://Buildng Powering Puzzle/Verification/Level 2/Dialogs/PuzzleVerifiedNo.tres")
var puzzle_completed = preload("res://Buildng Powering Puzzle/Verification/Level 2/Dialogs/PuzzleCompleted.tres")

var current_dialog = first_dialog
# export(Array, int) var preset_certificate = [3, 4, 5, 6]


func _ready():
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")


func interact():
	if current_dialog != null:
		$InteractableArea.disable()
		if current_dialog == in_puzzle_dialog:
			if any_room_unpowered():
				current_dialog = verified_no
			elif all_rooms_checked():
				current_dialog = verified_yes
		start_current_dialog()


func start_current_dialog():
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)


func start_level():
	for room in get_node("../Rooms").get_children():
		room.get_node("InteractableArea").enable()


func end_level():
	for room in get_node("../Rooms").get_children():
		if room.get_node("InteractableArea").enabled:
			room.get_node("InteractableArea").disable()
	get_node("../DoorOut").open_door()


func any_room_unpowered():
	for room in get_node("../Rooms").get_children():
		if room.frame == 1:
			return true
	return false


func all_rooms_checked():
	for room in get_node("../Rooms").get_children():
		if room.frame == 0:
			return false
	return true


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "First Dialog":
		current_dialog = in_puzzle_dialog
		start_level()
	elif dialog_name in ["Puzzle Verified Yes", "Puzzle Verified No"]:
		current_dialog = puzzle_completed
		end_level()
	
	$InteractableArea.enable()
