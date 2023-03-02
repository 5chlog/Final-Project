extends StaticBody2D
class_name NPC_re

# Change to AutoLoad later
onready var dialogbox: DialogBox_re = get_node("/root/Mailbox test Vivek/DialogBox re") as DialogBox_re

# Use Resouces of type DialogResource as elements
export(Array, Resource) var dialog_resources = []

func interact():
	print("Interacted")
	dialogbox.player = $InteractableArea.player
	dialogbox.enable_dialog_box(dialog_resources[0], self, $InteractableArea.player)
	$InteractableArea.active = false


func button_TL_function():
	print("Next Dialog clicked")
	dialogbox.enable_dialog_box(dialog_resources[1], self, $InteractableArea.player)


func button_TR_function():
	print("Close Dialog clicked")
	dialogbox.disable_dialog_box()
	$InteractableArea.active = true


func _on_dialogbox_closed():
	$InteractableArea.active = true
