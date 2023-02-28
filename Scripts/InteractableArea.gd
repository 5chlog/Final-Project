extends Area2D
class_name InteractableArea

var active: bool = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if active and Input.is_action_just_pressed("ui_accept"):
		if player == null:
			player = get_node("/root/World/Player")
		player.toggleHold()
		get_parent().interact()
	pass


func _on_InteractableArea_body_entered(body):
	if body is Player:
		print(get_parent())
		active = true
		$InteractSprite.visible = true
	pass # Replace with function body.


func _on_InteractableArea_body_exited(body):
	if body is Player:
		active = false
		$InteractSprite.visible = false
	pass # Replace with function body.
	
