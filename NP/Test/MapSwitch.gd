extends Sprite


onready var interactactable_area: InteractableArea = $InteractableArea
var extra_hud = null
var viewport_camera = null


func _ready():
	interactactable_area.disable()


func interact():
	interactactable_area.disable()
	
	var player = interactactable_area.player
	
	if viewport_camera == null:
		viewport_camera = get_node("/root/HUD/ExtraHUD/MapBorder/ViewportContainer/Viewport/Map/Camera2D")
		viewport_camera.player = player
	if viewport_camera.switch == null:
		viewport_camera.switch = self
	viewport_camera.active = true
	if extra_hud == null:
		extra_hud = get_node("/root/HUD/ExtraHUD")
	extra_hud.show_map()
