extends GridContainer


var menu_name = "Mechanic Verification Puzzle"


func _ready():
	var level_lost = ProgressData.level_lost_last[ProgressData.puzzle_types.MechanicPuzzle]
	if level_lost == 1 and 1 in ProgressData.mechanic_vf_levels_unlocked:
		$Level1Button.visible = true
	else:
		$Level1Button.visible = false
	
	if level_lost == 2 and 2 in ProgressData.mechanic_vf_levels_unlocked:
		$Level2Button.visible = true
	else:
		$Level2Button.visible = false
	
	if level_lost == 3 and 3 in ProgressData.mechanic_vf_levels_unlocked:
		$Level3Button.visible = true
	else:
		$Level3Button.visible = false
