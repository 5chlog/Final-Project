extends Sprite

# Dialogs
var first_dialog = preload("res://Santa Claus/Verification/Test/Dialogs/FirstDialog.tres")
var in_puzzle_dialog = preload("res://Santa Claus/Verification/Test/Dialogs/InPuzzleDialog.tres")
var verified_yes = preload("res://Santa Claus/Verification/Test/Dialogs/PuzzleVerifiedYes.tres")
var verified_no = preload("res://Santa Claus/Verification/Test/Dialogs/PuzzleVerifiedNo.tres")
var puzzle_completed = preload("res://Santa Claus/Verification/Test/Dialogs/PuzzleCompleted.tres")

var complete: bool = false
var threshold = Certificates.threshold
var current_dialog = first_dialog


func _ready():
	$AnimationPlayer.play("Idle")
	DialogBox.connect("dialogbox_closed", self, "_on_dialogbox_closed")


func interact():
	if current_dialog != null:
		$InteractableArea.disable()
		if current_dialog == in_puzzle_dialog:
			if any_child_unhappy():
				current_dialog = verified_no
			elif every_child_happy():
				current_dialog = verified_yes
		start_current_dialog()


func start_current_dialog():
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)


func start_level():
	for childvf in get_node("../Children").get_children():
		childvf.get_node("InteractableArea").enable()


func end_level():
	for childvf in get_node("../Children").get_children():
		if childvf.get_node("InteractableArea").enabled:
			childvf.get_node("InteractableArea").disable()
	get_node("../DoorOut").open_door()


func any_child_unhappy():
	for childvf in get_node("../Children").get_children():
		if childvf.checked and childvf.happiness < threshold:
			return true
	return false


func every_child_happy():
	for childvf in get_node("../Children").get_children():
		if !childvf.checked or childvf.happiness < threshold:
			return false
	return true


func _on_dialogbox_closed(dialog_name):
	if dialog_name == "First Dialog":
		current_dialog = in_puzzle_dialog
		start_level()
	elif dialog_name in ["Puzzle Verified Yes", "Puzzle Verified No"]:
		current_dialog = puzzle_completed
		ProgressData.lesson_3_completed = true
		end_level()
	
	$InteractableArea.enable()
