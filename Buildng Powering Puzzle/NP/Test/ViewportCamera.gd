extends Camera2D


const UNIT_HEIGHT = 48

var player: Player = null
var switch = null
var active: bool = false

var bottom_bound: int = 0
var top_bound: int = 0


func _ready():
	bottom_bound = get_node("../BuildingSprite").texture.get_size().y - get_viewport_rect().size.y
	if bottom_bound < 0:
		top_bound = bottom_bound
	position.y = bottom_bound


func _input(event):
	if not active:
		return
	
	if Input.is_action_just_pressed("game_up"):
		# Move Camera up
		if position.y > top_bound:
			position.y -= UNIT_HEIGHT
	elif Input.is_action_just_pressed("game_down"):
		# Move Camera down
		if position.y < bottom_bound:
			position.y += UNIT_HEIGHT
	elif Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("game_back"):
		get_tree().set_input_as_handled()
		
		# Disable the viewport, enable InteractableArea of Switch and return control to player
		active = false
		get_node("../../../../..").hide_map()
		switch.get_node("InteractableArea").enable()
		player.toggleHold()
