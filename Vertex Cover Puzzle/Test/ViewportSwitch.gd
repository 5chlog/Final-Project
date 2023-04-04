extends Sprite


onready var interactactable_area: InteractableArea = $InteractableArea

func _ready():
	pass
	# get_node("../MarginContainer/ViewportContainer/Viewport/Test Map Scene/Background").player


func interact():
	interactactable_area.disable()
	
	var player = interactactable_area.player
	var control = get_node("../Control")
	var viewport_camera = control.get_node("ViewportContainer/Viewport/Test Map/Camera2D")
	viewport_camera.player = player
	viewport_camera.switch = self
	viewport_camera.active = true
	viewport_camera.visible = true
	frame = 2
	
	var player_camera = player.get_node("Camera2D")
	var viewport_container = control.get_node("ViewportContainer")
	var viewport_node = viewport_container.get_node("Viewport")
	var displacement = Vector2(int(viewport_node.size.x / 2), int(viewport_node.size.y / 2))
	var cam_offset = Vector2(0, int(player_camera.offset.y))
	var new_pos = -player.position + control.rect_position + viewport_container.rect_position + displacement - cam_offset
	player.get_node("Camera2D").position = new_pos
