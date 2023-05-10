extends Sprite

# Dialogs
var first_dialog = preload("res://Santa Claus/NP/Test/Dialogs/FirstDialog.tres")
var puzzle_instr = preload("res://Santa Claus/NP/Test/Dialogs/PuzzleInstructions.tres")
var in_puzzle_dialog = preload("res://Santa Claus/NP/Test/Dialogs/InPuzzleDialog.tres")
var puzzle_yes_correct = preload("res://Santa Claus/NP/Test/Dialogs/PuzzleYesCorrect.tres")
var puzzle_yes_wrong = preload("res://Santa Claus/NP/Test/Dialogs/PuzzleYesWrong.tres")
var puzzle_yes_none = preload("res://Santa Claus/NP/Test/Dialogs/PuzzleYesNone.tres")
var puzzle_no_correct = preload("res://Santa Claus/NP/Test/Dialogs/PuzzleNoCorrect.tres")
var puzzle_no_wrong = preload("res://Santa Claus/NP/Test/Dialogs/PuzzleNoWrong.tres")
var puzzle_giveup = preload("res://Santa Claus/NP/Test/Dialogs/PuzzleGiveup.tres")
var puzzle_solved = preload("res://Santa Claus/NP/Test/Dialogs/PuzzleSolved.tres")
var to_verification = preload("res://Santa Claus/NP/Test/Dialogs/ToVerification.tres")


var complete: bool = false
var current_dialog = first_dialog
#Stores index values of each gift assigned to each child
var preset_certificate = [1, 2, 3, 4, 5]

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
		var happiness_value = 0
		if child.assigned_gift != null :
			happiness_value = child.assigned_gift.gift_values[child.child_index]
		if happiness_value < children.threshold:
			return false
	
	return true


func start_current_dialog():
	DialogBox.enable_dialog_box(current_dialog, self, $InteractableArea.player)


func start_level():
	get_node("../TransportSwitch/InteractableArea").enable()
	
	for slot in get_node("../GiftSlots").get_children():
		slot.get_node("InteractableArea").enable()
		
	get_node("../ChildDisplay/InteractableArea").enable()


func end_level():
	get_node("../TransportSwitch/InteractableArea").disable()
	
	for slot in get_node("../GiftSlots").get_children():
		slot.get_node("InteractableArea").disable()
		
	get_node("../ChildDisplay/InteractableArea").disable()
	# DialogBox.disconnect("dialogbox_closed", self, "_on_dialogbox_closed")


func set_certificate_from_level():
	var children = get_node("/root/HUD/ExtraHUD").get_children_node()
	var threshold = children.threshold
	Certificates.set_threshold(threshold)
	
	for child in children.get_children():
		if child.assigned_gift != null :
			Certificates.add_gift_textures(child.assigned_gift.texture)
			var happiness_value  = child.assigned_gift.gift_values[child.child_index]
			Certificates.add_happiness_values(happiness_value)
		else:
			Certificates.add_gift_textures(null)
			Certificates.add_happiness_values(-1)
			
	print(Certificates.gift_textures , "\n" , Certificates.happiness_values , "\n" , Certificates.threshold)


func set_certificate_from_preset():
	var children = get_node("/root/HUD/ExtraHUD").get_children_node()
	var gifts = get_node("../Gifts")
	preset_certificate.resize(children.get_child_count())
	Certificates.set_threshold(children.threshold)

	for i in preset_certificate.size():
		var found = false
		for gift in gifts.get_children() :
			if gift.gift_index == preset_certificate[i] :
				Certificates.add_gift_textures(gift.texture)
				Certificates.add_happiness_values(gift.gift_values[i])
				found = true
		if found :
			continue
		for child in children.get_children() :
			if child.assigned_gift != null :
				if  child.assigned_gift.gift_index == preset_certificate[i] :
					Certificates.add_gift_textures(child.assigned_gift.texture)
					Certificates.add_happiness_values(child.assigned_gift.gift_values[i]) 
					found = true
		if !found:
			print("You messed up the preset certificate")
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
	elif not get_parent().has_solution:
		current_dialog = puzzle_yes_none
	else:
		current_dialog = puzzle_yes_wrong
	
	start_current_dialog()


# No reply to In Puzzle Dialog
func in_puzzle_no():
	if get_parent().has_solution:
		current_dialog = puzzle_no_wrong
	else:
		current_dialog = puzzle_no_correct
		
	start_current_dialog()

# Give Up reply to In Puzzle Dialog
func in_puzzle_giveup():
	current_dialog = puzzle_giveup
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

