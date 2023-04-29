extends Sprite


var empty: bool = false


func _ready():
	var cell = get_node("../../Dismantler/PartsDisplay").get_child(get_index())
	if not cell.visible:
		return
	
	get_node("PartSprite").texture = cell.get_node("Part").texture
