extends Node2D

const SlotClass = preload("res://Inventory/Slot.gd")
onready var slots = $GridContainer
var has_item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for inventory_slot in slots.get_children():
		inventory_slot.connect("gui_input",self,"slot_gui_input",[inventory_slot])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		#If left mouse button is pressed
		if event.button_index == BUTTON_LEFT && event.pressed:
			#If you are holding an item
			if has_item != null:
				#If the slot is empty
				if !slot.item:
					slot.putIntoSlot(has_item)
					has_item = null
				#If the slot already has an item
				else:
					var _item = slot.item
					slot.pickFromSlot()
					_item.global_position = event.global_position
					slot.putIntoSlot(has_item)
					has_item = _item
			#If you are NOT holding an item, pick it up from slot
			elif slot.item:
				has_item = slot.item
				slot.pickFromSlot()
				has_item.global_position = get_global_mouse_position()
				
#If holding an item, update its location to mouse pointer location
func _input(event):
	if has_item:
		has_item.global_position = get_global_mouse_position()
