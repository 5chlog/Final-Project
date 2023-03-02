extends StaticBody2D
class_name NPC_re

# Change to AutoLoad later
onready var dialogbox: DialogBox_re = get_node("/root/Mailbox test Vivek/DialogBox re") as DialogBox_re

# Use Resouces of type DialogResource as elements
export(Array, Resource) var dialog_resources = []

func interact():
	print("Interacted")
	$InteractableArea.player.toggleHold()
	dialogbox.player = $InteractableArea.player
	dialogbox.prepare_dialog_box(dialog_resources[0], self)
