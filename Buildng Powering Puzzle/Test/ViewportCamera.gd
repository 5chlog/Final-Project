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
	
	if Input.is_action_just_pressed("ui_up"):
		get_tree().set_input_as_handled()
		
		# Move Camera up
		if position.y > top_bound:
			position.y -= UNIT_HEIGHT
	elif Input.is_action_just_pressed("ui_down"):
		get_tree().set_input_as_handled()
		
		# Move Camera down
		if position.y < bottom_bound:
			position.y += UNIT_HEIGHT
	elif Input.is_action_just_pressed("ui_accept"):
		get_tree().set_input_as_handled()
		
		var room: RoomEdge = get_node("../BuildingSprite/Graph/Rooms/Room 1")
		var gen_1: GeneratorVertex = get_node("../BuildingSprite/Graph/Generators/Generator 1")
		var gen_2: GeneratorVertex = get_node("../BuildingSprite/Graph/Generators/Generator 2")
		
		# Return disable the viewport, enable InteractableArea of Switch and control to player
		active = false
		get_node("../../../..").visible = false
		player.get_node("Camera2D").position = Vector2(0, 0)
		switch.get_node("InteractableArea").enable()
		switch.frame = 0
		player.toggleHold()
