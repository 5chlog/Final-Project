extends Control


var active_menu_container = null
var prev_menu_container = null
onready var back_button = get_node("BackButton")

# Menus
onready var start_menu_container = get_node("CenterContainer/StartMenu")
onready var lesson_menu_container = get_node("CenterContainer/LessonMenu")
onready var lesson_1_menu_container = get_node("CenterContainer/Lesson1Menu")
onready var lesson_2_menu_container = get_node("CenterContainer/Lesson2Menu")
onready var lesson_3_menu_container = get_node("CenterContainer/Lesson3Menu")
onready var mailbox_menu_container = get_node("CenterContainer/MailboxMenu")
onready var building_powering_menu_container = get_node("CenterContainer/BuildingPoweringMenu")
onready var mechanic_menu_container = get_node("CenterContainer/MechanicMenu")
onready var santa_claus_menu_container = get_node("CenterContainer/SantaClausMenu")
onready var building_powering_vf_menu_container = get_node("CenterContainer/BuildingPoweringVFMenu")
onready var mechanic_vf_menu_container = get_node("CenterContainer/MechanicVFMenu")
onready var santa_claus_vf_menu_container = get_node("CenterContainer/SantaClausVFMenu")


func _ready():
	active_menu_container = $CenterContainer/StartMenu
	set_menu_container(active_menu_container)


func set_menu_container(var menu_container: Container):
	if active_menu_container != null:
		active_menu_container.visible = false
	
	menu_container.visible = true
	$MenuNameLabel.text = menu_container.menu_name
	active_menu_container = menu_container
	set_prev_menu()
	set_focus_on_first_button(menu_container)
	if menu_container != start_menu_container:
		back_button.visible = true
	else:
		back_button.visible = false


func set_prev_menu():
	match active_menu_container:
		start_menu_container:
			prev_menu_container = null
			
		lesson_menu_container:
			prev_menu_container = start_menu_container
			
		lesson_1_menu_container:
			prev_menu_container = lesson_menu_container
			
		lesson_2_menu_container:
			prev_menu_container = lesson_menu_container
			
		lesson_3_menu_container:
			prev_menu_container = lesson_menu_container
		
		mailbox_menu_container:
			prev_menu_container = lesson_1_menu_container
		
		building_powering_menu_container:
			prev_menu_container = lesson_2_menu_container
		
		mechanic_menu_container:
			prev_menu_container = lesson_2_menu_container
		
		santa_claus_menu_container:
			prev_menu_container = lesson_2_menu_container
		
		building_powering_vf_menu_container:
			prev_menu_container = lesson_3_menu_container
		
		mechanic_vf_menu_container:
			prev_menu_container = lesson_3_menu_container
		
		santa_claus_vf_menu_container:
			prev_menu_container = lesson_3_menu_container
		
		_:
			prev_menu_container = null
		

func set_focus_on_first_button(var menu_container: Container):
	for child in menu_container.get_children():
		if child is Button:
			child.grab_focus()
			return


func _on_BackButton_pressed():
	print("Back Button pressed")
	if prev_menu_container != null:
		set_menu_container(prev_menu_container)


func _unhandled_input(event):
	if back_button.visible and Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()
