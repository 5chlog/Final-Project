extends Area2D

export(int) var targetmailslot = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	match targetmailslot:
		1:
			$Node2D/Mail1.frame = 1
		2:
			$Node2D/Mail2.frame = 1
		3:
			$Node2D/Mail3.frame = 1
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Mailbox_body_entered(body):
	if body is Player:
		$Node2D.visible = true


func _on_Mailbox_body_exited(body):
	if body is Player:
		$Node2D.visible = false
