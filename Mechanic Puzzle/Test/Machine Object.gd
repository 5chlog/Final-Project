extends Sprite
class_name MachineObject

onready var display = get_node("../../../../Display")
onready var conveyor = get_node("../../..")
export(Array, PartsDisplay.partNames) var parts

var selected = false


func _ready():
	var interactablearea = get_node("InteractableArea")
	interactablearea.connect("body_entered", self, "_Player_entered_area")
	interactablearea.connect("body_exited", self, "_Player_exited_area")
	interactablearea.disable()
	$SelectionSprite.visible = false
	
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
		$SelectionSprite.visible = false
		selected = false
	elif conveyor.selectable_object_count - conveyor.selected_object_count > 0:
		display.add_parts(parts)
		conveyor.selected_object_count += 1
		$SelectionSprite.visible = true
		selected = true
	
	var select_count_string = String(conveyor.selected_object_count) + "/" + String(conveyor.selectable_object_count)
	get_node("/root/HUD/Extra HUD/SelectCount/SelectCountLabel").text = select_count_string


func _Player_entered_area(var body):
	if body is Player and get_parent() == conveyor.bottom_panel:
		var extra_hud = get_node("/root/HUD/Extra HUD")
		extra_hud.show_parts(parts, self)


func _Player_exited_area(var body):
	if body is Player and get_parent() == conveyor.bottom_panel:
		var extra_hud = get_node("/root/HUD/Extra HUD")
		extra_hud.clear_parts(self)
