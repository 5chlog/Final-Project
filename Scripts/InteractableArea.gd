extends Area2D
class_name InteractableArea

var active: bool = false
var player = null
export(bool) var enabled = true


func _physics_process(_delta):
	if active and enabled and not DialogBox.visible and Input.is_action_just_pressed("ui_accept"):
		player.toggleHold()
		get_parent().interact()


func disable():
	enabled = false
	$InteractSprite.visible = false


func enable():
	enabled = true
	if active:
		$InteractSprite.visible = true

func _on_InteractableArea_body_entered(body):
	if body is Player:
		print(get_parent())
		active = true
		if enabled:
			$InteractSprite.visible = true
		if player == null:
			player = body


func _on_InteractableArea_body_exited(body):
	if body is Player:
		active = false
		$InteractSprite.visible = false
