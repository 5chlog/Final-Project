extends NinePatchRect


# Called when the node enters the scene tree for the first time.
func _ready():
	rect_position = get_node("../MapSwitch").position + Vector2(-107, -300)
