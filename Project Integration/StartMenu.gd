extends GridContainer


onready var main_menu = get_node("../..")
onready var lesson_menu = get_node("../LessonMenu")
onready var glossary_menu = get_node("../GlossaryMenu")
var menu_name = ""


func _on_StartButton_pressed():
	main_menu.set_menu_container(lesson_menu)


func _on_GlossaryButton_pressed():
	main_menu.set_menu_container(glossary_menu)


func _on_ExitButton_pressed():
	get_tree().quit()
