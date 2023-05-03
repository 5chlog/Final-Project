extends GridContainer


var menu_name = "Building Powering Puzzle"


func _ready():
	if 1 in ProgressData.building_powering_levels_unlocked:
		$Level1Button.visible = true
	else:
		$Level1Button.visible = false
	
	if 2 in ProgressData.building_powering_levels_unlocked:
		$Level2Button.visible = true
	else:
		$Level2Button.visible = false
	
	if 3 in ProgressData.building_powering_levels_unlocked:
		$Level3Button.visible = true
	else:
		$Level3Button.visible = false
