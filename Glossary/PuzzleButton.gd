extends Button

export(NodePath) var container_path
var container = null
onready var page_container = get_node("../../../PageContainer")
var building = ProgressData.building_powering_levels_unlocked
var buildingvf = ProgressData.building_powering_vf_levels_unlocked
var mechanic = ProgressData.mechanic_levels_unlocked
var mechanicvf = ProgressData.mechanic_vf_levels_unlocked
var santa = ProgressData.santa_claus_levels_unlocked
var santavf = ProgressData.santa_claus_vf_levels_unlocked
var mailbox = ProgressData.mailbox_levels_unlocked
var id = text

func _ready():
	container = get_node(container_path)
	if !mailbox.empty() and (id in ["Types of Problems", "P And EXP Algorithms", "Complexity Classes"]):
		visible = true
	elif id == "Mailbox" and mailbox.size() >= 2:
		visible = true
	elif id == "Class P" and (!mechanic.empty() or !building.empty() or !santa.empty()):
		visible = true
	elif id == "Building Powering" and building.size() >= 2:
		visible = true
	elif id == "Mechanic" and mechanic.size() >= 2:
		visible = true
	elif id == "Santa Claus" and santa.size() >= 2:
		visible = true
	elif (id == "Class NP" or id == "P Time Verification") and (buildingvf.size() >= 2 or mechanicvf.size() >= 2 or santavf.size() >= 2):
		visible = true
		
func _on_Button_pressed():
	var current_page = page_container.current_page
	if current_page != null:
		current_page.visible = false
	container.visible = true
	page_container.set_current_page(container)
