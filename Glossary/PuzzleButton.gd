extends Button

export(NodePath) var container_path
var container = null
onready var page_container = get_node("../../../PageContainer")
var building = ProgressData.building_powering_levels_unlocked
var mechanic = ProgressData.mechanic_levels_unlocked
var santa = ProgressData.santa_claus_levels_unlocked
var id = text

func _ready():
	container = get_node(container_path)
	if id == "Mailbox" or id == "Types of Problems" or id == "P And EXP Algorithms" or id == "Complexity Classes" or id == "Class P":
		visible = true
	elif id == "Building Powering"  and building[0] == 1:
		visible = true
	elif id == "Mechanic" and mechanic[0] == 1:
		visible = true
	elif id == "Santa Claus" and santa[0] == 1:
		visible = true
	elif (id == "P Time Verification" or id == "Class NP") and (mechanic[0] == 1 or building[0] == 1 or santa[0] == 1):
		visible = true
		
func _on_Button_pressed():
	var current_page = page_container.current_page
	if current_page != null:
		current_page.visible = false
	container.visible = true
	page_container.set_current_page(container)
