extends StaticBody2D

export(int) var solution_index_mailbox = -1
onready var mailboxes: Mailboxes = get_parent().get_node("Mailboxes")

onready var dialog_box: DialogBox_re = $"../DialogBox re"

export(Array, Resource) var dialog_resource

var first_interact:bool = true

func _ready():
	for i in mailboxes.get_child_count():
		if mailboxes.get_child(i).targetmailslot in [1, 2, 3]:
			solution_index_mailbox = i

func interact():
	if first_interact:
		dialog_box.enable_dialog_box( dialog_resource[0], self, $InteractableArea.player)
		first_interact = false
		$InteractableArea.active = false
		return
		
	if mailboxes.selectedmailbox == solution_index_mailbox:
		dialog_box.enable_dialog_box( dialog_resource[2], self, $InteractableArea.player)
#		$AnswerSprite.frame = 1
	else:
		dialog_box.enable_dialog_box( dialog_resource[3], self, $InteractableArea.player)
#		$AnswerSprite.frame = 2
	$InteractableArea.active = false

func sure_button():
	dialog_box.enable_dialog_box( dialog_resource[1], self, $InteractableArea.player)

func _on_dialogbox_closed():
	dialog_box.disconnect("dialogbox_closed", self, "_on_dialogbox_closed")
	$InteractableArea.active = true
