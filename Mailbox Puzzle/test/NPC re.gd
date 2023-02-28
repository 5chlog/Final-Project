extends Node2D
class_name NPC_re

# const DIALOGBOX = preload("res://Mailbox Puzzle/test/DialogBox.tscn")
# var dialogbox = DIALOGBOX.instance()
onready var dialogbox = get_node("/root/Mailbox test Vivek/DialogBox re") as DialogBox_re
onready var dialogboxcontainer = dialogbox.get_child(0)

func interact():
	print("Interacted")
	$InteractableArea.player.toggleHold()
	dialogboxcontainer.player = $InteractableArea.player
	dialogbox.visible = true
	dialogboxcontainer.grab_focus()
	# get_parent().add_child(dialogbox)
	pass
