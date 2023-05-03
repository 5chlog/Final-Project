extends GridContainer


onready var main_menu = get_node("../..")
onready var building_powering_menu_container = get_node("../BuildingPoweringMenu")
onready var mechanic_menu_container = get_node("../MechanicMenu")
onready var santa_claus_menu_container = get_node("../SantaClausMenu")
var menu_name = "Lesson 2"


func _ready():
	if ProgressData.puzzle_types.BuildingPoweringPuzzle in ProgressData.lesson_2_puzzles_unlocked:
		$BuildingPoweringPuzzleButton.visible = true
	else :
		$BuildingPoweringPuzzleButton.visible = false
	
	if ProgressData.puzzle_types.MechanicPuzzle in ProgressData.lesson_2_puzzles_unlocked:
		$MechanicPuzzleButton.visible = true
	else :
		$MechanicPuzzleButton.visible = false
	
	if ProgressData.puzzle_types.SantaClausPuzzle in ProgressData.lesson_2_puzzles_unlocked:
		$SantaClausPuzzleButton.visible = true
	else :
		$SantaClausPuzzleButton.visible = false


func _on_BuildingPoweringPuzzleButton_pressed():
	main_menu.set_menu_container(building_powering_menu_container)


func _on_MechanicPuzzleButton_pressed():
	main_menu.set_menu_container(mechanic_menu_container)


func _on_SantaClausPuzzleButton_pressed():
	main_menu.set_menu_container(santa_claus_menu_container)
