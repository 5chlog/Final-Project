extends CanvasLayer

onready var screen: Sprite = get_child(0)
onready var display = get_node("../Display")
var parts_on_screen: int  = 0

var temp = 0 # Remove along with _physics_process


func _ready():
	screen.frame = 1
	visible = false


# Remove _physics_process after objects are completed in Conveyor Test.tscn
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if temp == 0:
			equip()
		elif temp == 1:
			show_parts([display.partNames.SCREW, display.partNames.BATTERY])
		elif temp == 2:
			clear_parts()
		temp += 1


func equip():
	visible = true
	pass


func unequip():
	visible = false
	pass


func show_parts(var parts: Array):
	parts_on_screen = 0
	for part in parts:
		var cell = screen.get_child(parts_on_screen)
		# if display.partsDictionary[part][0]:
		# Indent from here
		cell.get_child(0).texture = display.partsDictionary[part][1]
		cell.visible = true
		parts_on_screen += 1
		# Indent till here
	
	if parts_on_screen > 0:
		screen.frame = 0


func clear_parts():
	if parts_on_screen == 0:
		return
	for i in parts_on_screen:
		var cell = screen.get_child(i)
		cell.visible = false
	screen.frame = 1
	parts_on_screen = 0
