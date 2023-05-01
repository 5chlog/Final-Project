extends GridContainer


onready var main_menu = get_node("../..")
onready var building_powering_menu_container = get_node("../BuildingPoweringMenu")
onready var mechanic_menu_container = get_node("../MechanicMenu")
onready var santa_claus_menu_container = get_node("../SantaClausMenu")


func _on_BuildingPoweringPuzzleButton_pressed():
	main_menu.set_menu_container(building_powering_menu_container)


func _on_MechanicPuzzleButton_pressed():
	main_menu.set_menu_container(mechanic_menu_container)


func _on_SantaClausPuzzleButton_pressed():
	main_menu.set_menu_container(santa_claus_menu_container)
