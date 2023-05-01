extends Area2D
class_name Mailbox


export(int) var target_mail_slot = 0
var active: bool = false


func _ready():
	match target_mail_slot:
		1:
			$Mails/Mail1.frame = 1
		2:
			$Mails/Mail2.frame = 1
		3:
			$Mails/Mail3.frame = 1


func _on_Mailbox_body_entered(body):
	if active and body is Player:
		$Mails.visible = true


func _on_Mailbox_body_exited(body):
	if active and body is Player:
		$Mails.visible = false


func interact():
	var mailbox_index = get_index()
	var mailboxes: Mailboxes = get_parent()
	var selected_mailbox = mailboxes.selected_mailbox
	
	match selected_mailbox:
		-1:
			$OutlineSprite.visible = true
			mailboxes.selected_mailbox = mailbox_index
		mailbox_index:
			mailboxes.selected_mailbox = -1
			$OutlineSprite.visible = false
		_:
			mailboxes.get_child(selected_mailbox).get_node("OutlineSprite").visible = false
			$OutlineSprite.visible = true
			mailboxes.selected_mailbox = mailbox_index

	$InteractableArea.player.toggleHold()
