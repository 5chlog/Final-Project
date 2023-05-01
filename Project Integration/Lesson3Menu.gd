extends GridContainer


onready var main_menu = get_node("../..")
onready var building_powering_vf_menu_container = get_node("../BuildingPoweringVFMenu")
onready var mechanic_vf_menu_container = get_node("../MechanicVFMenu")
onready var santa_claus_vf_menu_container = get_node("../SantaClausVFMenu")


func _on_BuildingPoweringVFPuzzleButton_pressed():
	main_menu.set_menu_container(building_powering_vf_menu_container)


func _on_MechanicPuzzleVFButton_pressed():
	main_menu.set_menu_container(mechanic_vf_menu_container)


func _on_SantaClausPuzzleVFButton_pressed():
	main_menu.set_menu_container(santa_claus_vf_menu_container)
