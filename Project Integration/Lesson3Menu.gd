extends GridContainer


onready var main_menu = get_node("../..")
onready var building_powering_vf_menu_container = get_node("../BuildingPoweringVFMenu")
onready var mechanic_vf_menu_container = get_node("../MechanicVFMenu")
onready var santa_claus_vf_menu_container = get_node("../SantaClausVFMenu")
var menu_name = "Lesson 3"


func _ready():
	if ProgressData.puzzle_types.BuildingPoweringPuzzle in ProgressData.lesson_3_puzzles_unlocked:
		$BuildingPoweringVFPuzzleButton.visible = true
	else :
		$BuildingPoweringVFPuzzleButton.visible = false
	
	if ProgressData.puzzle_types.MechanicPuzzle in ProgressData.lesson_3_puzzles_unlocked:
		$MechanicVFPuzzleButton.visible = true
	else :
		$MechanicVFPuzzleButton.visible = false
	
	if ProgressData.puzzle_types.SantaClausPuzzle in ProgressData.lesson_3_puzzles_unlocked:
		$SantaClausVFPuzzleButton.visible = true
	else :
		$SantaClausVFPuzzleButton.visible = false


func _on_BuildingPoweringVFPuzzleButton_pressed():
	main_menu.set_menu_container(building_powering_vf_menu_container)


func _on_MechanicPuzzleVFButton_pressed():
	main_menu.set_menu_container(mechanic_vf_menu_container)


func _on_SantaClausPuzzleVFButton_pressed():
	main_menu.set_menu_container(santa_claus_vf_menu_container)
