extends Sprite

onready var conveyor = get_node("../Conveyor")

func interact():
	if conveyor.player == null:
		conveyor.player = $InteractableArea.player
	if conveyor.switch == null:
		conveyor.switch = self
	conveyor.activate()
	frame = 2
	$InteractableArea.disable()
	pass
