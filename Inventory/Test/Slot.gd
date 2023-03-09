extends Panel

# Preload textures for slots
var default_tex = preload("res://images/item_slot_default_background.png")
var empty_tex = preload("res://images/item_slot_empty_background.png")

# Define styles for textures
var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

# Preload item
var itemClass = preload("res://Inventory/Test/Item.tscn")
var item = null
var slot_index

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	#if randi() % 2 == 0:
	#	item = itemClass.instance()
	#	add_child(item)
	refresh_style()
	
# If slot is empty, use empty texture and empty style, use default style otherwise
func refresh_style():
	if item == null:
		set('custom_styles/panel',empty_style)
	else:
		set('custom_styles/panel',default_style)

# Function to remove item from slot
func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null
	refresh_style()

# Functino to add item to slot	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()
	
func initialize_item(item_name, item_quantity):
	if item == null:
		item = itemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
	refresh_style()
