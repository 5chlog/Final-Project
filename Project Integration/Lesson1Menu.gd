extends GridContainer


onready var main_menu = get_node("../..")
onready var mailbox_menu = get_node("../MailboxMenu")


func _on_MailboxPuzzleButton_pressed():
	main_menu.set_menu_container(mailbox_menu)
