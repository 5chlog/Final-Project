extends Sprite
class_name MachineObject

onready var display = get_node("../../../Display")
export(Array, PartsDisplay.partNames) var parts


func _ready():
	var interactablearea = get_child(0)
	interactablearea.connect("body_entered", self, "_Player_entered_area")
	interactablearea.connect("body_exited", self, "_Player_exited_area")
	interactablearea.disable()


func interact():
	pass


func _Player_entered_area(var body):
	if body is Player:
		var scanner = get_node("../../../Scanner")
		scanner.show_parts(parts, self)


func _Player_exited_area(var body):
	if body is Player:
		var scanner = get_node("../../../Scanner")
		scanner.clear_parts(self)
