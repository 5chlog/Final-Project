extends GridContainer


onready var main_menu = get_node("../..")
onready var lesson_menu = get_node("../LessonMenu")
var menu_name = ""


func _on_StartButton_pressed():
	main_menu.set_menu_container(lesson_menu)


func _on_ExitButton_pressed():
	get_tree().quit()
