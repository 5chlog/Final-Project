extends Sprite
class_name MachineObject

onready var display = get_node("../../../Display")
# export(Array, display.partNames) var parts


func _ready():
	get_child(0).connect("body_entered", self, "_Player_entered_area")
	get_child(0).connect("body_exited", self, "_Player_exited_area")


func interact():
	pass


func _Player_entered_area(var body):
	if body is Player:
		var scanner = get_node("../../../Scanner")
		scanner.show_parts([display.partNames.SCREW, display.partNames.BATTERY], self)


func _Player_exited_area(var body):
	if body is Player:
		var scanner = get_node("../../../Scanner")
		scanner.clear_parts(self)
