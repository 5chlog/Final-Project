extends Sprite


onready var interactactable_area: InteractableArea = $InteractableArea

func _ready():
	pass
	# get_node("../MarginContainer/ViewportContainer/Viewport/Test Map Scene/Background").player


func interact():
	interactactable_area.disable()
	var player = interactactable_area.player
	var control = get_node("../Control")
	var background = control.get_node("ViewportContainer/Viewport/Test Map/Background")
	background.player = player
	background.switch = self
	background.active = true
	control.visible = true
	
	var player_camera = player.get_node("Camera2D")
	var viewport_node = control.get_node("ViewportContainer/Viewport")
	var displacement = Vector2(viewport_node.size.x / 2, viewport_node.size.y / 2 
			- player_camera.offset.y) 
	var new_pos = -player.position + control.rect_position + displacement
	player.get_node("Camera2D").position = new_pos
	frame = 2
