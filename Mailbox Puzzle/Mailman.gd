extends StaticBody2D

export(int) var solution_index_mailbox = -1
onready var mailboxes: Mailboxes = get_parent().get_node("Mailboxes")

func _ready():
	for i in mailboxes.get_child_count():
		if mailboxes.get_child(i).targetmailslot in [1, 2, 3]:
			solution_index_mailbox = i

func interact():
	if mailboxes.selectedmailbox == solution_index_mailbox:
		$AnswerSprite.frame = 1
	else:
		$AnswerSprite.frame = 2
	$InteractableArea.player.toggleHold()
