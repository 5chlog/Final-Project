extends GridContainer


onready var main_menu = get_node("../..")
onready var lesson_1_menu = get_node("../Lesson1Menu")
onready var lesson_2_menu = get_node("../Lesson2Menu")
onready var lesson_3_menu = get_node("../Lesson3Menu")


func _ready():
	if 1 in ProgressData.lessons_unlocked:
		$Lesson1Button.visible = true
	else :
		$Lesson1Button.visible = false
	
	if 2 in ProgressData.lessons_unlocked:
		$Lesson2Button.visible = true
	else :
		$Lesson2Button.visible = false
	
	if 3 in ProgressData.lessons_unlocked:
		$Lesson3Button.visible = true
	else :
		$Lesson3Button.visible = false
	


func _on_Lesson1Button_pressed():
	main_menu.set_menu_container(lesson_1_menu)


func _on_Lesson2Button_pressed():
	main_menu.set_menu_container(lesson_2_menu)


func _on_Lesson3Button_pressed():
	main_menu.set_menu_container(lesson_3_menu)
