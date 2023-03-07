extends Node2D

var item_name
var item_quantity

func _ready():
	pass
	#var rand_val = randi() % 3
	#if rand_val == 0:
	#	item_name = "Iron Sword"
	#elif rand_val == 1:
	#	item_name = "Tree Branch"
	#elif rand_val == 2:
	#	item_name = "Slime Potion"

	#$TextureRect.texture = load("res://item_icons/" + item_name + ".png")
	#var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	#item_quantity = randi() % stack_size + 1
	
	#if stack_size == 1:
	#	$TextureRect/Label.visible = false
	#else:
	#	$TextureRect/Label.text = String(item_quantity)
		
func add_items(n):
	item_quantity += n
	$TextureRect/Label.text = String(item_quantity)

func remove_items(n):
	item_quantity -= n
	$TextureRect/Label.text = String(item_quantity)
	
func set_item(name, quantity):
	item_name = name
	item_quantity = quantity[1]
	$TextureRect.texture = load("res://item_icons/" + item_name + ".png")
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$TextureRect/Label.visible = false
	else:
		$TextureRect/Label.visible = true
		$TextureRect/Label.text = String(item_quantity)
