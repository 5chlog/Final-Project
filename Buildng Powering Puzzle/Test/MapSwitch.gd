extends Sprite


onready var interactactable_area: InteractableArea = $InteractableArea
onready var map_border = get_node("../MapBorder")
var const_displacement: Vector2 = Vector2.ZERO


func _ready():
	var viewport_container = map_border.get_node("ViewportContainer")
	var viewport_node = viewport_container.get_node("Viewport")
	var vp_centre = Vector2(int(viewport_node.size.x / 2), int(viewport_node.size.y / 2))
	const_displacement =  map_border.rect_position + viewport_container.rect_position + vp_centre


func interact():
	interactactable_area.disable()
	
	var player = interactactable_area.player
	var viewport_camera = map_border.get_node("ViewportContainer/Viewport/Map/Camera2D")
	viewport_camera.player = player
	viewport_camera.switch = self
	viewport_camera.active = true
	map_border.visible = true
	
	# Setting Player's Camera to centre of the Map (Viewport)
	var cam_offset = Vector2(0, int(player.get_node("Camera2D").offset.y))
	player.get_node("Camera2D").position = const_displacement - player.position - cam_offset
