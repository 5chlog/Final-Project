extends Button

export(NodePath) var container_path
var container = null
onready var page_container = get_node("../../../PageContainer")
var building = ProgressData.building_powering_levels_unlocked
var mechanic = ProgressData.mechanic_levels_unlocked
var santa = ProgressData.santa_claus_levels_unlocked
var mailbox = ProgressData.mailbox_levels_unlocked
var id = text

func _ready():
	container = get_node(container_path)
	if !mailbox.empty() and (id in ["Mailbox", "Types of Problems", "P And EXP Algorithms", "Complexity Classes", "Class P"]):
		visible = true
	elif id == "Building Powering" and !building.empty():
		visible = true
	elif id == "Mechanic" and !mechanic.empty():
		visible = true
	elif id == "Santa Claus" and !santa.empty():
		visible = true
	elif (id == "P Time Verification" or id == "Class NP") and (!mechanic.empty() or !building.empty() or !santa.empty()):
		visible = true
		
func _on_Button_pressed():
	var current_page = page_container.current_page
	if current_page != null:
		current_page.visible = false
	container.visible = true
	page_container.set_current_page(container)
