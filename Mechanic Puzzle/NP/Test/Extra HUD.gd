extends Node2D

const CELL_COUNT = 16

onready var scanner: Sprite = get_node("Scanner")
onready var animationplayer: AnimationPlayer = get_node("AnimationPlayer")
onready var display = get_node("/root/Level/Display")
var parts_on_screen: int  = 0
var calling_node = null


func _ready():
	scanner.frame = 1
	visible = false
	$SelectCount/SelectCountLabel.text = "0/" + String(get_node("/root/Level/Conveyor").selectable_object_count)


func equip_scanner():
	animationplayer.play("Slide Scanner In")


func show_select_count():
	animationplayer.play("Show Select Count")


func unequip_scanner():
	animationplayer.play("Slide Scanner Out")


func hide_select_count():
	animationplayer.play("Hide Select Count")


func show_parts(var parts: Array, var caller):
	calling_node = caller
	
	for i in CELL_COUNT:
		var cell = scanner.get_child(i)
		cell.visible = false
	get_node("Scanner/EmptyMsg").visible = false
	
	parts_on_screen = 0
	for part in parts:
		var cell = scanner.get_child(parts_on_screen)
		cell.get_child(0).texture = display.partsDictionary[part][1]
		cell.visible = true
		parts_on_screen += 1
		if parts_on_screen >= CELL_COUNT:
			break
	
	scanner.frame = 0
	if parts_on_screen == 0:
		get_node("Scanner/EmptyMsg").visible = true


func clear_parts(var caller):
	if calling_node != caller:
		return
	for i in CELL_COUNT:
		var cell = scanner.get_child(i)
		cell.visible = false
	get_node("Scanner/EmptyMsg").visible = false
	scanner.frame = 1
	parts_on_screen = 0
