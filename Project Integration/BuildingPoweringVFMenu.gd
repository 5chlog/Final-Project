extends GridContainer


var menu_name = "Building Powering Verification Puzzle"


func _ready():
	var level_lost = ProgressData.level_lost_last[ProgressData.puzzle_types.BuildingPoweringPuzzle]
	if level_lost == 1 and 1 in ProgressData.building_powering_vf_levels_unlocked:
		$Level1Button.visible = true
	else:
		$Level1Button.visible = false
	
	if level_lost == 2 and 2 in ProgressData.building_powering_vf_levels_unlocked:
		$Level2Button.visible = true
	else:
		$Level2Button.visible = false
	
	if level_lost == 3 and 3 in ProgressData.building_powering_vf_levels_unlocked:
		$Level3Button.visible = true
	else:
		$Level3Button.visible = false
