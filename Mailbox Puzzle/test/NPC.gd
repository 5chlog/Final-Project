extends Area2D

var can_interact = false
const DIALOG = preload("res://Mailbox Puzzle/test/DialogBox.tscn")

func _on_Area2D_body_entered(body):
	if body is Player:
		$Label.visible = true
		can_interact = true

func _on_Area2D_body_exited(body):
	if body is Player:
		$Label.visible = false
		can_interact = false

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and can_interact == true:
		$Label.visible = false
		var dialog = DIALOG.instance()
		get_parent().add_child(dialog)
