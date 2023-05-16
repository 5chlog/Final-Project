extends Button


export(NodePath) var container_path
var container = null
onready var page_container = get_node("../../../PageContainer")


func _ready():
	container = get_node(container_path)


func _on_Button_pressed():
	var current_page = page_container.current_page
	if current_page != null:
		current_page.visible = false
	container.visible = true
	page_container.set_current_page(container)
