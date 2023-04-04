extends Sprite


const UNIT_HEIGHT = 48

var player: Player = null
var switch = null
var active: bool = false


func _ready():
	position.y = get_viewport_rect().size.y - texture.get_size().y


func _input(event):
	if not active:
		return
	
	if Input.is_action_just_pressed("ui_up"):
		get_tree().set_input_as_handled()
		
		# Move Sprite down
		position.y += UNIT_HEIGHT
	elif Input.is_action_just_pressed("ui_down"):
		get_tree().set_input_as_handled()
		
		# Move Sprite up
		position.y -= UNIT_HEIGHT
	elif Input.is_action_just_pressed("ui_accept"):
		get_tree().set_input_as_handled()
		
		# Return disable the viewport, enable InteractableArea of Switch and control to player
		active = false
		get_node("../../../..").visible = false
		player.get_node("Camera2D").position = Vector2(0, 0)
		switch.get_node("InteractableArea").enable()
		switch.frame = 0
		player.toggleHold()
