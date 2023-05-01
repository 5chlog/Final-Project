extends GridContainer


onready var main_menu = get_node("../..")
onready var lesson_1_menu = get_node("../Lesson1Menu")
onready var lesson_2_menu = get_node("../Lesson2Menu")
onready var lesson_3_menu = get_node("../Lesson3Menu")


func _on_Lesson1Button_pressed():
	main_menu.set_menu_container(lesson_1_menu)


func _on_Lesson2Button_pressed():
	main_menu.set_menu_container(lesson_2_menu)


func _on_Lesson3Button_pressed():
	main_menu.set_menu_container(lesson_3_menu)
