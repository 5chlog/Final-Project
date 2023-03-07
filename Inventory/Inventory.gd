extends Node2D

const SlotClass = preload("res://Inventory/Slot.gd")
onready var slots = $GridContainer
var has_item = null

func _ready():
	for inventory_slot in slots.get_children():
		inventory_slot.connect("gui_input",self,"slot_gui_input",[inventory_slot])
	initialize_inventory()

func initialize_inventory():
	var inv_slots = slots.get_children()
	for i in range(inv_slots.size()):
		if PlayerInventory.inventory.has(i):
			inv_slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		# If left mouse button is pressed
		if event.button_index == BUTTON_LEFT && event.pressed:
			# If you are holding an item
			if has_item != null:
				# If the slot is empty
				if !slot.item:
					slot.putIntoSlot(has_item)
					has_item = null
				# If the slot already has an item
				else:
					# If the slot has different item, simply swap - no need to merge
					if has_item.item_name != slot.item.item_name:
						var _item = slot.item
						slot.pickFromSlot()
						_item.global_position = event.global_position
						slot.putIntoSlot(has_item)
						has_item = _item
					# If the slot has the same item, try to merge
					else:
						var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
						# You can add items if quantity to add <= remaining stack size
						var can_add = stack_size - slot.item.item_quantity
						if can_add >= has_item.item_quantity:
							slot.item.add_items(has_item.item_quantity)
							has_item.queue_free()
							has_item = null
			# If you are NOT holding an item, pick it up from slot
			elif slot.item:
				has_item = slot.item
				slot.pickFromSlot()
				has_item.global_position = get_global_mouse_position()
				
# If holding an item, update its location to mouse pointer location
func _input(event):
	if has_item:
		has_item.global_position = get_global_mouse_position()
