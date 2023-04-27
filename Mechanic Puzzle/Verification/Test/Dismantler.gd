extends Node2D


var active: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func interact():
	active = true
	$InteractableArea.disable()


func _input(_event):
	if not active:
		return
	
	if Input.is_action_just_pressed("game_back"):
		active = false
		$InteractableArea.enable()
		$InteractableArea.player.toggleHold()
