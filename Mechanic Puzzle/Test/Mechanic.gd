extends Sprite

var first_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleStartDialog.tres")
var puzzle_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/InPuzzleDialog.tres")
var instructions_dialog = preload("res://Mechanic Puzzle/Test/Dialogs/PuzzleInstructions.tres")
var current_dialog = null
var started: bool = false


func _ready():
	get_node("../Scanner/AnimationPlayer").connect("animation_finished", self, 
			"_scanner_anim_completed")


func interact():
	if not started:
		current_dialog = first_dialog
	else:
		current_dialog = puzzle_dialog
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)


func button_TL_function(): # Yes
	DialogBox.disable_dialog_box()
	$InteractableArea.player.toggleHold()
	$InteractableArea.disable()
	get_node("../Scanner").equip()


func button_TR_function(): # No
	DialogBox.disable_dialog_box()


func _scanner_anim_completed(anim_name):
	if started:
		return
	
	if anim_name == "Slide In":
		current_dialog = instructions_dialog
		DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)
		
		var bottom_panel = get_node("../Conveyor").bottom_panel
		for child in bottom_panel.get_children():
			if child is MachineObject:
				child.get_node("InteractableArea").enable()
		get_node("../ConveyorSwitch/InteractableArea").enable()
		started = true
		$InteractableArea.enable()
	pass
