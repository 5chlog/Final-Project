extends CanvasLayer

const CELL_COUNT = 16

onready var screen: Sprite = get_node("Screen Sprite")
onready var animationplayer: AnimationPlayer = get_node("AnimationPlayer")
onready var display = get_node("../Display")
var parts_on_screen: int  = 0
var calling_node = null


func _ready():
	screen.frame = 1
	visible = false


func equip():
	animationplayer.play("Slide In")
	pass


func unequip():
	animationplayer.play("Slide Out")
	pass


func show_parts(var parts: Array, var caller):
	calling_node = caller
	
	for i in CELL_COUNT:
		var cell = screen.get_child(i)
		cell.visible = false
	
	parts_on_screen = 0
	for part in parts:
		var cell = screen.get_child(parts_on_screen)
		# if part in display.parts_used:
		# Indent from here
		cell.get_child(0).texture = display.partsDictionary[part][1]
		cell.visible = true
		parts_on_screen += 1
		# Indent till here
	
	if parts_on_screen > 0:
		screen.frame = 0


func clear_parts(var caller):
	if calling_node != caller:
		return
	for i in CELL_COUNT:
		var cell = screen.get_child(i)
		cell.visible = false
	screen.frame = 1
	parts_on_screen = 0
