extends GridContainer


onready var main_menu = get_node("../..")
onready var mailbox_menu = get_node("../MailboxMenu")
var menu_name = "Lesson 1"


func _ready():
	if ProgressData.puzzle_types.MailboxPuzzle in ProgressData.lesson_1_puzzles_unlocked:
		$MailboxPuzzleButton.visible = true
	else :
		$MailboxPuzzleButton.visible = false


func _on_MailboxPuzzleButton_pressed():
	main_menu.set_menu_container(mailbox_menu)
