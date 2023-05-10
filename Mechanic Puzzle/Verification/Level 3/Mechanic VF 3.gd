extends Sprite


var started: bool = false

# Dialogs
var first_dialog = preload("res://Mechanic Puzzle/Verification/Level 3/Dialogs/FirstDialog.tres")
var puzzle_dialog = preload("res://Mechanic Puzzle/Verification/Level 3/Dialogs/InPuzzleDialog.tres")
var puzzle_verified_yes_dialog = preload("res://Mechanic Puzzle/Verification/Level 3/Dialogs/PuzzleVerifiedYesDialog.tres")
var puzzle_verified_no_dialog = preload("res://Mechanic Puzzle/Verification/Level 3/Dialogs/PuzzleVerifiedNoDialog.tres")
var puzzle_completed_dialog = preload("res://Mechanic Puzzle/Verification/Level 3/Dialogs/PuzzleCompletedDialog.tres")

var current_dialog = first_dialog


func _ready():
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")


func interact():
	if current_dialog != null:
		$InteractableArea.disable()
		if current_dialog == puzzle_dialog:
			if all_boxes_has_parts():
				current_dialog = puzzle_verified_yes_dialog
			elif all_objects_dismantled():
				current_dialog = puzzle_verified_no_dialog
		start_current_dialog()


func start_current_dialog():
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)


# Returns true if all boxes turned their display Green; false otherwise
func all_boxes_has_parts():
	for box in get_node("../Boxes").get_children():
		if box.frame == 0:
			return false
	
	return true


# Returns true if all MachineObjects are dismantled; false otherwise
func all_objects_dismantled():
	for dismantled in get_node("../Dismantler").machine_dismantled:
		if not dismantled:
			return false
	
	return true


# Activates the puzzle elements in the scene
func start_level():
	get_node("../Dismantler/InteractableArea").enable()


# Deactivates the puzzle elements in the scene
func end_level():
	HUD.get_node("ExtraHUD").queue_free()
	get_node("../Dismantler/InteractableArea").disable()
	get_node("../DoorOut").open_door()


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "First Dialog":
		start_level()
		current_dialog = puzzle_dialog
	elif dialog_name in ["Puzzle Verified Yes Dialog", "Puzzle Verified No Dialog"]:
		end_level()
		ProgressData.lesson_3_completed = true
		current_dialog = puzzle_completed_dialog
	
	$InteractableArea.enable()
