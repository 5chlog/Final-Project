extends Sprite

var firstdialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleStartDialog.tres")
var puzzledialog = preload("res://Mechanic Puzzle/Test/Dialogs/InPuzzleDialog.tres")
var started: bool = false


func interact():
	if not started:
		DialogBox.enable_dialog_box(firstdialog, self, $InteractableArea.player)
	else:
		DialogBox.enable_dialog_box(puzzledialog, self, $InteractableArea.player)


func button_TL_function(): # Yes
	DialogBox.disable_dialog_box()
	var bottom_panel = get_node("../Conveyor").bottom_panel
	for child in bottom_panel.get_children():
		if child is MachineObject:
			child.get_node("InteractableArea").enable()
	get_node("../ConveyorSwitch/InteractableArea").enable()
	get_node("../Scanner").equip()
	started = true


func button_TR_function(): # No
	DialogBox.disable_dialog_box()
