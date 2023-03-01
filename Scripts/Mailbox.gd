extends Area2D
class_name Mailbox

export(int) var targetmailslot = 0

func _ready():
	match targetmailslot:
		1:
			$Node2D/Mail1.frame = 1
		2:
			$Node2D/Mail2.frame = 1
		3:
			$Node2D/Mail3.frame = 1

func _on_Mailbox_body_entered(body):
	if body is Player:
		$Node2D.visible = true

func _on_Mailbox_body_exited(body):
	if body is Player:
		$Node2D.visible = false

func interact():
	var mailboxindex = get_index()
	var parent: Mailboxes = get_parent()
	var selectedmailbox = parent.selectedmailbox
	
	match selectedmailbox:
		-1:
			$OutlineSprite.visible = true
			parent.selectedmailbox = mailboxindex
		mailboxindex:
			parent.selectedmailbox = -1
			$OutlineSprite.visible = false
		_:
			parent.get_child(selectedmailbox).get_node("OutlineSprite").visible = false
			$OutlineSprite.visible = true
			parent.selectedmailbox = mailboxindex

	$InteractableArea.player.toggleHold()
