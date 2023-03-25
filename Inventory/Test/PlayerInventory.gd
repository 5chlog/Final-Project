extends Node

const INVENTORY_SLOTS = 20
const SlotClass = preload("res://Inventory/Test/Slot.gd")
const ItemClass = preload("res://Inventory/Test/Item.gd")

var inventory = {
	0: ["Iron Sword", 1],
	1: ["Iron Sword", 1],
	2: ["Slime Potion", 98],
	3: ["Slime Potion", 45]
}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var can_add = stack_size - inventory[item][1]
			if can_add >= item_quantity:
				inventory[item][1] += item_quantity
				return
			else:
				inventory[item][1] += can_add
				item_quantity -= can_add
			
	for i in range(INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return

func _ready():
	pass 

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]
	
func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)
	
func add_item_quantity(slot: SlotClass, n: int):
	inventory[slot.slot_index][1] += n
