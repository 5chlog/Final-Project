extends StaticBody2D

var solution_index_mailbox:int = -1
onready var mailboxes: Mailboxes = get_parent().get_node("Mailboxes")
onready var door = get_parent().get_node("Door 3-conclusion")

export(Array, Resource) var dialog_resource

var first_interact:bool = true

func _ready():
	for i in mailboxes.get_child_count():
		if mailboxes.get_child(i).targetmailslot in [1, 2, 3]:
			solution_index_mailbox = i

func interact():
	if first_interact:
		DialogBox.enable_dialog_box( dialog_resource[0], self, $InteractableArea.player)
		first_interact = false
		return
		
	if mailboxes.selectedmailbox == solution_index_mailbox:
		DialogBox.enable_dialog_box( dialog_resource[1], self, $InteractableArea.player)
		door.collision_layer = 0
		door.get_node("Sprite").frame = 1
#		$AnswerSprite.frame = 1
	else:
		DialogBox.enable_dialog_box( dialog_resource[2], self, $InteractableArea.player)
#		$AnswerSprite.frame = 2

#func sure_button():
#	dialog_box.enable_dialog_box( dialog_resource[1], self, $InteractableArea.player)
