extends Sprite
class_name MachineObject

onready var display = get_node("../../../Display")
onready var conveyor = get_node("../..")
export(Array, PartsDisplay.partNames) var parts

var selected = false


func _ready():
	var interactablearea = get_child(0)
	interactablearea.connect("body_entered", self, "_Player_entered_area")
	interactablearea.connect("body_exited", self, "_Player_exited_area")
	interactablearea.disable()
	
	var parts_available = []
	for part in parts:
		if part in display.parts_used:
			parts_available.append(part)
	parts = parts_available


func interact():
	$InteractableArea.player.toggleHold()
	
	if selected:
		display.remove_parts(parts)
		conveyor.selected_object_count -= 1
		selected = false
	elif conveyor.selectable_object_count - conveyor.selected_object_count > 0:
		display.add_parts(parts)
		conveyor.selected_object_count += 1
		selected = true
		
		for i in display.parts_used:
			if display.partsDictionary[i][0] == 0:
				return
			
		print("Puzzle completed successfully")


func _Player_entered_area(var body):
	if body is Player and get_parent() == conveyor.bottom_panel:
		var scanner = get_node("../../../Scanner")
		scanner.show_parts(parts, self)


func _Player_exited_area(var body):
	if body is Player and get_parent() == conveyor.bottom_panel:
		var scanner = get_node("../../../Scanner")
		scanner.clear_parts(self)
